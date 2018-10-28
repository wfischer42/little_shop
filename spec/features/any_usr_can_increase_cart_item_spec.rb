require 'rails_helper'

describe 'user increase item' do
  it 'lets user increase item quantity in the cart' do
    item_3 = create(:item)
    item_3 = create(:item)
    visit item_path(item_3)
    click_on "Add to Cart"

    first(:button, "+").click
    within("td.quantity-#{item_3.id}")do
      expect(page).to have_content(2)
    end

    # expect(page).to have_button('+', disabled: true)
  end
end
