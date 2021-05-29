class OrdersController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @orders = current_user.orders.where(stripe_payment_status:  true)
    end
end