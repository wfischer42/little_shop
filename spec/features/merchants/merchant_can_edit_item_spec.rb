require 'rails_helper'

describe 'Merchant new item' do

before(:each) do
  @merchant = create(:user, role: 1)
  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)
  @item = create(:item, user: @merchant)
  @item_2 = create(:item, user: @merchant)
  visit merchant_items_path
  first(:link, "Edit").click
  expect(current_path).to eq(edit_merchant_item_path(@item))
  fill_in :item_name, with: "Atari"
  fill_in :item_description, with: "The best game system ever!"
  fill_in :item_img_url, with: "https://media.giphy.com/media/MjkIEw6qWPVsc/giphy.gif"
  fill_in :item_price, with: 100
  fill_in :item_inventory_count, with: 13
end
  it 'lets merchant edit an item' do
    click_button "Update Item"

    expect(current_path).to eq(merchant_items_path)
    expect(page).to have_content("Item Updated")

  end

  it 'fails edit if name is not filled in' do
    fill_in :item_name, with: ""
    click_button "Update Item"

    expect(current_path).to eq(edit_merchant_item_path(@item))
    expect(page).to have_content("Error, missing field. Please try again")
  end

  it 'fails edit if description is not filled in' do
    fill_in :item_description, with: ""
    click_button "Update Item"

    expect(current_path).to eq(edit_merchant_item_path(@item))
    expect(page).to have_content("Error, missing field. Please try again")
  end

  it 'fails edit if price is less than 0' do
    fill_in :item_price, with: "-.01"
    click_button "Update Item"

    expect(current_path).to eq(edit_merchant_item_path(@item))
    expect(page).to have_content("Error, missing field. Please try again")
  end

  it 'fails edit if inventory count is less than 0' do
    fill_in :item_price, with: "-1"
    click_button "Update Item"

    expect(current_path).to eq(edit_merchant_item_path(@item))
    expect(page).to have_content("Error, missing field. Please try again")
  end
end
