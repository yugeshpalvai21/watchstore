class ChargesController < ApplicationController
    before_action :authenticate_user!, only: [:create]
    before_action :check_cart, only: [:create]
    before_action :set_cart, only: [:create]

    def create
        @session = Stripe::Checkout::Session.create({
            payment_method_types: ['card'],
            customer: current_user.stripe_customer_id,
            line_items: line_items_data,
            mode: 'payment',
            success_url: success_charges_url + "?session_id={CHECKOUT_SESSION_ID}",
            cancel_url: cancel_charges_url + "?session_id={CHECKOUT_SESSION_ID}"
        })
        create_order_and_update_line_items
        respond_to do |format|
           format.js 
        end
    end

    def success
      if params[:session_id]
        @session = Stripe::Checkout::Session.retrieve({ id: params[:session_id] }) 
        if @session && @session.payment_status == "paid"
          set_order
          update_order
        end
      end
      redirect_to root_path
    end

    def cancel
      redirect_to root_path, notice: 'Payment Cancelled'
    end

    private

    def set_cart
      @cart = current_user.cart
    end

    def line_items_data
      @cart.line_items.map do |line_item| 
        {
          price_data: {
            currency: 'inr',
            product_data: {
              name: line_item.product.title
            },
            unit_amount: line_item.product.price * 100
          },
          quantity: 1
        }
      end
    end

    def check_cart
      if current_user.cart.line_items.empty?
        redirect_to request.referrer, notice: 'please add products to cart before checkout'
      end
    end

    def create_order_and_update_line_items
      @order = current_user.orders.create(stripe_session_id: @session.id)  
      current_user.cart.line_items.each do |line_item|
        line_item.update(order: @order)
      end
    end

    def set_order
      @order = Order.where(stripe_session_id: @session.id).first
    end

    def update_order
      if @order && !@order.stripe_payment_status
        @order.update(stripe_payment_status: true, stripe_payment_intent: @session.payment_intent, stripe_paid_amount: @session.amount_total/100)
        empty_user_cart
        flash[:notice] = "Order Placed Succeesully..."
      end
    end

    def empty_user_cart
      @order.line_items.each { |line_item| line_item.update(cart_id: nil) }
    end
end