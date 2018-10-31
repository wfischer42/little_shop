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
  end
    it 'lets merchant edit an item' do

      fill_in :item_name, with: "Atari"
      fill_in :item_description, with: "The best game system ever!"
      fill_in :item_img_url, with: "https://media.giphy.com/media/MjkIEw6qWPVsc/giphy.gif"
      fill_in :item_price, with: 100
      fill_in :item_inventory_count, with: 13
      click_button "Update Item"

      expect(current_path).to eq(merchant_items_path)
    end
end
