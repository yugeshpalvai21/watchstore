class RemoveColumnFromCart < ActiveRecord::Migration[6.1]
  def change
    remove_column :carts, :grand_total
  end
end
