require 'rails_helper'

describe 'user increase item' do
  it 'lets user increase item quantity in the cart' do
    item_10 = create(:item, inventory_count: 3)

    visit item_path(item_10)
    click_on "Add to Cart"
    visit item_path(item_10)
    click_on "Add to Cart"

    first(:button, "+").click
    within("td.quantity-#{item_10.id}")do
      expect(page).to have_content(3)
    end

    expect(page).to have_button('+', disabled: true)
  end
end
