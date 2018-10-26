require 'rails_helper'

describe 'Item Show Page' do
  it 'shows particular item' do
    item = create(:item)
    item_2 = create(:item)

    visit items_path

    click_link "#{item.name}"

    expect(page).to have_content(item.name)
    expect(page).to have_content(item.price)
    expect(page).to have_content("Inventory Count: #{item.inventory_count}")
    expect(page).to have_content(item.description)
    expect(page).to_not have_content(item_2.name)

  end
end
