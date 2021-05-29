class AddStripePaidAmountToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :stripe_paid_amount, :integer, default: 0, null: false
  end
end
