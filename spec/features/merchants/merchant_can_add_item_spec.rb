require 'rails_helper'

describe 'Merchant new item' do
  before(:each) do
    @merchant = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)
    visit merchant_items_path
    click_link "Add New Item"
    fill_in :item_name, with: "Atari"
    fill_in :item_description, with: "The best game system ever!"
    fill_in :item_img_url, with: "https://media.giphy.com/media/MjkIEw6qWPVsc/giphy.gif"
    fill_in :item_price, with: 100
    fill_in :item_inventory_count, with: 13

  end
  it "Merchant can add an item to their items page" do
    click_button "Create Item"
    new_item = Item.last

    expect(current_path).to eq(merchant_items_path)
    expect(page).to have_content(new_item.name)
    expect(page).to have_content(new_item.price)
    expect(page).to have_content(new_item.inventory_count)
    expect(page).to have_content("#{new_item.name} added to your items")
  end

  it 'It shows error message if name not added' do
    fill_in :item_name, with: ""

    click_button "Create Item"
    expect(page).to have_content("Item not added")
  end

  it 'It shows error message if description not added' do
    fill_in :item_description, with: ""
    click_button "Create Item"

    expect(page).to have_content("Item not added")
  end

  it 'It shows error message if price not added' do
    fill_in :item_price, with: ''
    click_button "Create Item"

    expect(page).to have_content("Item not added")
  end

  it 'It shows error message if inventory count not added' do
    fill_in :item_inventory_count, with: ''
    click_button "Create Item"

    expect(page).to have_content("Item not added")
  end

  it 'It shows error message if price is negative added' do
    fill_in :item_price, with: (-1.00)
    click_button "Create Item"

    expect(page).to have_content("Item not added")
  end

end
