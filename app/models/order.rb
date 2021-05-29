class Order < ApplicationRecord
  belongs_to :user
  has_many :line_items

  def total_amount
    amount = 0
    line_items.each { |line_item| amount += line_item.product.price }
    amount
  end
end
