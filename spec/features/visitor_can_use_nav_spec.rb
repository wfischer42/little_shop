require 'rails_helper'

describe 'visitor can use nav links' do
  it 'navigates to correct links' do
    visit root_path

    click_link "Items"

    expect(current_path).to eq(items_path)
    expect(page).to have_content("All Items")

    click_link "LittleShop"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Welcome To LittleShop")

    click_link "Merchants"

    expect(current_path).to eq(merchants_path)
    expect(page).to have_content("All Merchants")

    click_link "Cart"

    expect(current_path).to eq(cart_path)
    expect(page).to have_content("Your Cart")

  end
end
