class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  validates :item_price, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :item_quantity, presence: true, numericality: {greater_than: 0}

  def self.for_order_from_merchant(user_id, order_id)
    joins(:item).where('order_id = ? AND user_id = ?', order_id, user_id )
  end

end
