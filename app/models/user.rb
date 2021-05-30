class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  after_create do
    Cart.create(user: self)
    stripe_customer = Stripe::Customer.create(email: self.email)
    update(stripe_customer_id: stripe_customer.id)
  end

  has_one :cart
  has_many :orders
end
