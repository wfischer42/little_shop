require 'rails_helper'

describe 'Merchant items index' do
  before(:each) do
    @merchant = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)
    @item, @item_2 = create_list(:item, 2, user: @merchant)
    @item_3 = create(:item)
    visit merchant_items_path
  end

  it 'lets merchant view their items only' do
    expect(page).to have_link("Add New Item")
    expect(page).to have_content(@item.name)
    expect(page).to have_content(@item.id)
    expect(page).to have_content(@item.price)
    expect(page).to have_content(@item.inventory_count)
    expect(page).to have_content(@item_2.name)
    expect(page).to have_content(@item_2.id)
    expect(page).to have_content(@item_2.price)
    expect(page).to have_content(@item_2.inventory_count)
    expect(page).to_not have_content(@item_3.name)
  end

  it 'lets merchant disble/enable an item' do
    first(:button, "Disable").click

    expect(current_path).to eq(merchant_items_path)
    visit items_path

    expect(page).to_not have_content(@item.name)

    visit merchant_items_path
    first(:button, "Enable").click

    expect(page).to have_content(@item.name)
  end


end
