require 'rails_helper'

describe 'visitor can use nav links' do
  it 'navigates to correct links' do
    visit root_path

    click_link "Items"

    expect(current_path).to eq(items_path)
    expect(page).to have_content("All Items")

  end
end
