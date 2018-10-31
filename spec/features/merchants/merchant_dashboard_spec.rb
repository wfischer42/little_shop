require 'rails_helper'

describe 'merchant views own dashboard' do
  before (:each) do
    merchant = create(:user, role: 1)
    item = create_list(:item, 2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

    visit dashboard_path
  end

  it 'has link to view merchant items' do

    click_link "My Items"

    expect(current_path).to eq(merchant_items_path)
  end

  it 'should not see the link to orders if users havent order any items form merchant ' do

    expect(page).to_not have_link("My Orders")
    
  end
end
