require 'rails_helper'

describe 'visitor can add items to cart' do
  it 'shows cart with items in it' do
    item, item_2 = create_list(:item, 2)
    visit item_path(item)
    click_on "Add to Cart"
    visit item_path(item)
    click_on "Add to Cart"

    expect(current_path).to eq(cart_path)
    expect(page).to have_content(item.name)
    expect(page).to have_content(item.merchant.name)
    expect(page).to have_content(item.price)
    within("td.quantity-#{item.id}")do
      expect(page).to have_content(2)
    end
    within("td.sub-#{item.id}")do
      expect(page).to have_content(item.price * 2)
    end
    visit item_path(item_2)
    click_on "Add to Cart"

    expect(current_path).to eq(cart_path)
    expect(page).to have_content(item_2.name)
    expect(page).to have_content(item_2.merchant.name)
    expect(page).to have_content(item_2.price)
    within("td.quantity-#{item_2.id}")do
      expect(page).to have_content(1)
    end
    within("td.sub-#{item_2.id}")do
      expect(page).to have_content(item_2.price)
    end

    expect(page).to have_content((item_2.price) + (item.price * 2))
    click_on "Empty Cart"

    expect(current_path).to eq(cart_path)
    expect(page).to_not have_content(item.name)
    expect(page).to_not have_content(item_2.name)
    expect(page).to have_content("Grand Total: $0.00")
  end
end
