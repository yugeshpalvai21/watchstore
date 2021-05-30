class LineItemsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_cart
    before_action :set_product, only: [:create]

    def create
        if item_already_added?
            redirect_to request.referrer, notice: 'Product Already Added To Cart...'
        else
            LineItem.create(product: @product, cart: @cart) 
            redirect_to request.referrer, notice: 'Product Added To Cart...'
        end
    end

    def destroy
        @cart.line_items.where(id: params[:id]).first.destroy
        redirect_to carts_path, notice: 'Removed Item From Cart...'
    end

    private

    def set_cart
        @cart = current_user.cart
    end

    def set_product
        @product = Product.find(params[:product_id])
    end

    def item_already_added?
        @cart.line_items.pluck(:product_id).include? @product.id
    end
end