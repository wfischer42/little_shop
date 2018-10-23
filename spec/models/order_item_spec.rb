require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it {is_expected.to belong_to(:order) }
  it {is_expected.to belong_to(:item) }
  it {is_expected.to validate_presence_of(:item_quantity) }
  it {is_expected.to validate_presence_of(:item_price) }
  it {is_expected.to validate_numericality_of(:item_quantity).is_greater_than(0) }
  it {is_expected.to validate_numericality_of(:item_price).is_greater_than_or_equal_to(0) }
end
