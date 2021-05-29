class ChargesController < ApplicationController
    before_action :authenticate_user!, only: [:create]
    before_action :check_cart, only: [:create]

    def create
        @cart = current_user.cart

        @session = Stripe::Checkout::Session.create({
            payment_method_types: ['card'],
            customer_email: current_user.email,
            line_items: line_items_data,
            mode: 'payment',
            # These placeholder URLs will be replaced in a following step.
            success_url: success_charges_url + "?session_id={CHECKOUT_SESSION_ID}",
            cancel_url: cancel_charges_url + "?session_id={CHECKOUT_SESSION_ID}"
        })

        @order = current_user.orders.build
        @order.stripe_session_id = @session.id
        @order.save

        current_user.cart.line_items.each do |line_item|
          line_item.update(order: @order)
        end

        respond_to do |format|
           format.js 
        end
    end

    def success
      if params[:session_id]
        @session = Stripe::Checkout::Session.retrieve({ id: params[:session_id] }) 
        if @session && @session.payment_status == "paid"
          @order = Order.where(stripe_session_id: @session.id).first
          if @order && !@order.stripe_payment_status
            @order.stripe_payment_status = true
            @order.stripe_payment_intent = @session.payment_intent
            @order.save
            @order.line_items.each do |line_item|
              line_item.update(cart_id: nil)
            end
            current_user.cart.update(grand_total: 0)
            flash[:notice] = "Order Placed Succeesully..."
          end
        end
        redirect_to root_path
      else
        redirect_to root_path, notice: 'nothing to display'
      end
    end

    def cancel
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
end