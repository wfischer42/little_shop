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

  def grand_total
    order_items.pluck('sum(item_price * item_quantity)').first
  end

  def unit_quantity
    order_items.pluck('sum(item_quantity)').first
  end

  def self.largest_order_from(merchant)
    select('orders.id, sum(order_items.item_quantity)')
    .joins(order_items: :item)
    .where(order_items: {fulfilled: true},
           items:       {merchant: merchant})
    .group('orders.id')
    .order('sum desc').limit(1)
    .first
  end

  def self.highest_order_quantities
    select('orders.id, sum(order_items.item_quantity) as total_quantity').joins(:order_items).where('order_items.fulfilled = true').group('orders.id').order('total_quantity desc').limit(3)
  end

end
