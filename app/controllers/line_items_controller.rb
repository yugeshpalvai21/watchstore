class LineItemsController < ApplicationController
    before_action :authenticate_user!


    def create
        current_user.cart.line_items.create(product_id: params[:product_id])
        @cart = current_user.cart
        @cart.grand_total += Product.find(params[:product_id]).price
        @cart.save
        redirect_to request.referrer
    end
end