require 'rails_helper'

describe 'Admin goes to merchant profile page' do
  it 'can downgrade a merchant to a user' do
    admin =  create(:user, role: 2)
    merchant = create(:user, role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit admin_merchant_path(merchant)

    click_button("Downgrade to Customer Only Account")
    merchant_rename = User.find(merchant.id)
    expect(merchant_rename.role).to eq('customer')
  end

end
