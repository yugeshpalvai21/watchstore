class ChargesController < ApplicationController
    def create
        @product = Product.find(params[:product_id])
        @session = Stripe::Checkout::Session.create({
            payment_method_types: ['card'],
            line_items: [{
              price_data: {
                currency: 'inr',
                product_data: {
                  name: @product.title,
                },
                unit_amount: @product.price * 100,
              },
              quantity: 1,
            }],
            mode: 'payment',
            # These placeholder URLs will be replaced in a following step.
            success_url: success_charge_url(@product.id),
            cancel_url: cancel_charge_url(@product.id)
        })
        respond_to do |format|
           format.js 
        end
    end

    def success
        
    end

    def cancel
    end
end