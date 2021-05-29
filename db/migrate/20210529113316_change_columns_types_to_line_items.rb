class ChangeColumnsTypesToLineItems < ActiveRecord::Migration[6.1]
  def change
    change_column :line_items, :cart_id, :integer, null: true
    change_column :line_items, :order_id, :integer, null: true
  end
end
