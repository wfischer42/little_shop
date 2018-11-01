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

  def total_items_sold
    items.joins(:order_items).where('order_items.fulfilled = true').sum('order_items.item_quantity')
  end

  def merchant_orders
    Order.joins(:items)
    .where('items.user_id = ?', self.id)
    .order(:id)
  end

  def total_inventory
    items.sum(:inventory_count)
  end

  def top_states
    User.select(:state)
        .where('users.id IN (?)',
               self.items
               .select('orders.user_id')
               .joins(order_items: :order)
               .where('order_items.fulfilled = true'))
        .group(:state)
        .order('total_from_state desc')
        .limit(3)
        .pluck('users.state,
          count(users.state) AS total_from_state')
  end

  def top_cities
    User.select(:city)
        .where('users.id IN (?)',
                self.items
                .select('orders.user_id')
                .joins(order_items: :order)
                .where('order_items.fulfilled = true'))
        .group(:city)
        .order('total_from_city desc')
        .limit(3)
        .pluck('users.city,
          count(users.city) AS total_from_city')
  end

  def top_customers
    User.joins(orders: :order_items)
        .where('users.id IN (?) AND order_items.id IN (?)',
                self.items
                .select('orders.user_id')
                .joins(order_items: :order)
                .where('order_items.fulfilled = true'),
                self.items
                .select('order_items.id')
                .joins(:order_items)
                .where('order_items.fulfilled = true'))
        .group('users.name')
        .order('total_spent desc')
        .limit(3)
        .pluck('users.name,
                sum(order_items.item_quantity * order_items.item_price)
                AS total_spent')
  end

  def most_active_customer
    User.joins(orders: :order_items)
        .where('users.id IN (?)',
                self.items
                .select('orders.user_id')
                .joins(order_items: :order)
                .where('order_items.fulfilled = true'))
        .group('users.name')
        .order('total_items desc')
        .limit(1)
        .pluck('users.name, count(order_items) as total_items')
  end

  def largest_order
    Order.largest_order_from(self)
  end

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

  def self.slowest_merchants
    select('users.*, avg(order_items.updated_at - order_items.created_at) as fulfillment_time')
    .joins(items: :order_items)
    .where('order_items.fulfilled = true')
    .group('users.id')
    .order('fulfillment_time desc')
    .limit(3)
  end

  def self.biggest_spenders
    select('users.name, sum(order_items.item_quantity * order_items.item_price) as total_spending')
    .joins(orders: :order_items)
    .where('order_items.fulfilled = true')
    .group('users.name')
    .order('total_spending desc')
    .limit(3)
  end

  def self.top_selling_merchants
    select('users.*, sum(order_items.item_quantity * order_items.item_price) as total_profit')
    .joins(items: :order_items)
    .where('order_items.fulfilled = true')
    .group('users.id')
    .order('total_profit asc')
    .limit(3)
  end

end
