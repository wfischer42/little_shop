class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  validates :item_price, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :item_quantity, presence: true, numericality: {greater_than: 0}

  def self.for_order_from_merchant(user_id, order_id)
    joins(:item).where('order_id = ? AND user_id = ?', order_id, user_id )
  end

  def self.top_states
    select('users.state, count(users.state) as state_total').joins(order: :user).where('order_items.fulfilled = true').group('users.state').order('state_total desc').limit(3)
  end

  def self.top_cities
    select('users.city, count(users.city) as city_total').joins(order: :user).where('order_items.fulfilled = true').group('users.city').order('city_total desc').limit(3)
  end
end
