class CartItem < SimpleDelegator
  attr_reader :quant
  def initialize(item, quantity=0)
    super(item)
    @quant = quantity
  end

  def sub(item)
    item.price * @quant
  end

end
