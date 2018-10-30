class User < ApplicationRecord
  has_many :orders
  has_many :items

  validates_presence_of :name, :address, :city, :state,
                        :zip_code, :role, :email,
                        require: true

  validates :zip_code, numericality: true
  validates :email, uniqueness: true

  validates_presence_of :password, :on => :create

  has_secure_password
  has_many :orders

  enum role: [:customer, :merchant, :admin]

  def merchant_orders
    Order.joins(:items).where('items.user_id = ?', self.id)
  end
end
