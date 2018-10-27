require 'rails_helper'

describe 'visitor can add items to cart' do
  it 'shows cart with items in it' do
    item, item_2 = create_list(:item, 2)
    visit item_path(item)

    click_on "Add to Cart"

    expect(current_path).to eq(cart_path)
    expect(page).to have_content(item.name)
    expect(page).to have_content(item.price)

    visit item_path(item_2)

    click_on "Add to Cart"

    expect(current_path).to eq(cart_path)
    expect(page).to have_content(item_2.name)
    expect(page).to have_content(item_2.price)\
  end
end
