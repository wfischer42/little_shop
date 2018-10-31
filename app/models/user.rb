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

  enum role: [:customer, :merchant, :admin]

  def self.most_popular_merchants
    select('users.*, sum(order_items.item_quantity) as total_orders')
    .joins(items: :order_items)
    .where('order_items.fulfilled = true')
    .group('users.id')
    .order('total_orders desc')
    .limit(5)
  end

  def self.fastest_merchants
    select('users.*, avg(order_items.updated_at - order_items.created_at) as fulfillment_time')
    .joins(items: :order_items)
    .where('order_items.fulfilled = true')
    .group('users.id')
    .order('fulfillment_time asc')
    .limit(3)
  end

  def merchant_orders
    Order.joins(:items)
    .where('items.user_id = ?', self.id)
    .order(:id)
  end
end
