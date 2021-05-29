class AddOrderToLineItems < ActiveRecord::Migration[6.1]
  def change
    add_reference :line_items, :order, null: true, foreign_key: true
  end
end
