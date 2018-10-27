class Cart
  attr_reader :data

  def initialize(data)
    @data = data || Hash.new
  end

  def remove_item(id)
    data.delete(id.to_s)
  end

  def add_item_to_cart(item)
    data[item.id.to_s] ||= 0
    data[item.id.to_s] += 1
  end

  def decrease_item(item)
    if data[item.id.to_s] > 1
      data[item.id.to_s] ||= 0
      data[item.id.to_s] -= 1
    end
  end

  def total
    cart_items = items
    result = cart_items.inject(0) do |sum, cart_item|
      sum + cart_item.subtotal(cart_item)
    end
    result
  end

  def count_items
    cart_items = @data
    cart_items.values.sum
  end

  def items
    @data.map do |item_id, quantity|
      item = Item.find(item_id)
      CartItem.new(item, quantity)
    end
  end




end
