require 'rails_helper'

describe 'merchant views own dashboard' do
  it 'has link to view merchant items' do
    merchant = create(:user, role: 1)
    item = create_list(:item, 2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

    visit dashboard_path

    click_link "My Items"

    expect(current_path).to eq(merchant_items_path)
  end
end
