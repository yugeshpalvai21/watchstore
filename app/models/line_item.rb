class LineItem < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :product
  belongs_to :order, optional: true

  after_create :update_cart_total

  def update_cart_total
   cart = self.cart
   cart.grand_total += Product.find(product_id).price
   cart.save 
  end
end
