class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  validates_presence_of :status

  enum status: [:pending, :canceled, :fulfilled]

  def add_cart_items(cart_items)
    cart_items.each do |item|
      order_items.create( item_id: item.id,
                          item_price: item.price,
                          item_quantity: item.quant)
    end
  end
end
