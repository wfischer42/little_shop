require 'rails_helper'

describe 'User visits Item index' do
  before(:each) do
    @item_1, @item_2, @item_4, @item_6 = create_list(:item, 4)
    @item_3 = create(:item, active: false)
    @item_5 = create(:item, active: false)
  end

  it 'should go and see info of items and mechants' do
    visit items_path

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_1.price)
    expect(page).to have_content(@item_1.inventory_count)
    expect(page).to have_css(".img_url")
    expect(page).to have_content(@item_1.merchant.name)

    expect(page).to have_content(@item_2.name)
    expect(page).to have_content(@item_2.merchant.name)

    expect(page).to_not have_content(@item_3.name)
    expect(page).to_not have_content(@item_5.name)

    expect(page).to have_content(@item_6.name)
    expect(page).to have_content(@item_6.merchant.name)
  end
end
