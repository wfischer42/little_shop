class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  validates :item_price, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :item_quantity, presence: true, numericality: {greater_than: 0}

  def self.specific_item(order_id, item_id)
    OrderItem.where('order_id = ? AND item_id = ?', order_id, item_id)
  end
end
