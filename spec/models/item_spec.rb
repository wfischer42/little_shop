require 'rails_helper'

RSpec.describe Item, type: :model do
  it{ is_expected.to validate_presence_of(:name) }
  it{ is_expected.to validate_presence_of(:price) }
  it{ is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  it{ is_expected.to validate_numericality_of(:inventory_count).is_greater_than_or_equal_to(0) }
  it{ is_expected.to validate_presence_of(:description) }
  it{ is_expected.to validate_presence_of(:img_url) }
  it{ is_expected.to belong_to(:merchant) }
  it{ is_expected.to have_many(:order_items) }
  it{ is_expected.to have_many(:orders).through(:order_items) }



end
