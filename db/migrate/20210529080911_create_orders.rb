class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :stripe_session_id
      t.string :stripe_payment_intent
      t.boolean :stripe_payment_status

      t.timestamps
    end
  end
end
