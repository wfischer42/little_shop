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

  def cart_total
    cis = items
    result = cis.inject(0) do |sum, cis|
      sum + cis.sub(cis)
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

  def poop_on
    @data = Hash.new()
  end

end
