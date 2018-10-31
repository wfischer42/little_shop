require 'rails_helper'

RSpec.describe 'admin can view a specific merchants items' do
  before do
    @merchant = create(:user, role: 1)
    @merchant_2 = create(:user, role: 1)
    @admin = create(:user, role: 2)

    @item_1, @item_2, @item_3, @item_4, @item_5 = create_list(:item, 5, user: @merchant)
    @item_6 = create(:item, user: @merchant, active: false)

    @item_6, @item_7, @item_8, @item_9, @item_10 = create_list(:item, 5, user: @merchant_2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

  end

  it 'should see a link to edit the merchants items on merchant profile' do
    visit admin_merchant_path(@merchant)
    expect(page).to have_content("Edit Items")
  end

  it 'can visit a merchant items page' do
    visit admin_merchant_path(@merchant)
    click_link("Edit Items")

    expect(current_path).to eq(admin_merchant_items_path(@merchant))
  end

  it 'only sees that merchants items' do
    visit admin_merchant_items_path(@merchant)

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)
    expect(page).to have_content(@item_3.name)
    expect(page).to have_content(@item_4.name)
    expect(page).to have_content(@item_5.name)

    expect(page).to_not have_content(@item_6.name)
    expect(page).to_not have_content(@item_7.name)
    expect(page).to_not have_content(@item_8.name)
    expect(page).to_not have_content(@item_9.name)
    expect(page).to_not have_content(@item_10.name)
  end

  it 'can disable merchant items' do
    visit admin_merchant_items_path(@merchant)
    first(:button, "Disable").click

    item = Item.find(@item_1.id)
    expect(item.active?).to eq(false)
  end

  it 'can enable merchant items' do
    visit admin_merchant_items_path(@merchant)
    first(:button, "Enable").click

    item = Item.find(@item_6.id)
    expect(item.active?).to eq(true)
  end

  it 'can edit merchant items' do
    visit admin_merchant_items_path(@merchant)
    first(:link, "Edit Item").click

    fill_in :item_name, with: "CHANGE"
    click_button("Update Item")

    item = Item.find(@item_1.id)
    expect(item.name).to eq("CHANGE")
  end

  it 'can only edit merchant items if all required fields are filled out' do
    visit admin_merchant_items_path(@merchant)
    first(:link, "Edit Item").click

    fill_in :item_name, with: ""
    click_button("Update Item")

    expect(page).to have_content("Error")
    expect(current_path).to eq(admin_merchant_item_path(@merchant.id, @item_1.id))
  end

  it 'can add a new item for a merchant' do
    visit admin_merchant_items_path(@merchant)
    first(:link, "Add New Item").click

    fill_in :item_name, with: "NEW TEST ITEM"
    fill_in :item_description, with: "testing"
    fill_in :item_price, with: "1"
    fill_in :item_inventory_count, with: "1"
    click_button("Create Item")

    expect(current_path).to eq(admin_merchant_items_path(@merchant))
    expect(page).to have_content("NEW TEST ITEM")
    expect(@merchant.items.count).to eq(7)
  end

  it 'cannot add a new item for a merchant if all the info isnt filled out' do
    visit admin_merchant_items_path(@merchant)
    first(:link, "Add New Item").click

    fill_in :item_name, with: ""
    fill_in :item_description, with: "testing"
    fill_in :item_price, with: "2"
    fill_in :item_inventory_count, with: "2"
    click_button("Create Item")

    expect(page).to have_content("Item not able to be added, please review form")
    expect(@merchant.items.count).to eq(6)
  end
end
