class ChargesController < ApplicationController
    def create
        @cart = current_user.cart

        @session = Stripe::Checkout::Session.create({
            payment_method_types: ['card'],
            customer_email: current_user.email,
            line_items: line_items_data,
            mode: 'payment',
            # These placeholder URLs will be replaced in a following step.
            success_url: success_charge_url(@cart.id),
            cancel_url: cancel_charge_url(@cart.id)
        })
        respond_to do |format|
           format.js 
        end
    end

    def success
        @cart = Cart.find(params[:id])  

        redirect_to root_path
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
end