class PagesController < ApplicationController
  def home
    @products = Product.order('created_at DESC')
  end
end
