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

  describe 'can edit profile information' do
    it 'sees a button to edit profile information and button takes you to an update form' do

    admin =  create(:user, role: 2)
    merchant = create(:user, role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit admin_merchant_path(merchant)

    click_link("Edit Profile Information")
    expect(current_path).to eq(edit_admin_merchant_path(merchant))
    expect(page).to have_button("Update User")
    end

    it 'can change and save user information' do
      admin =  create(:user, role: 2)
      merchant = create(:user, role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit edit_admin_merchant_path(merchant)

      fill_in :user_name, with: "CHANGE NAME"
      fill_in :user_address, with: "123 Main Street"
      fill_in :user_city, with: "Fakeville"
      fill_in :user_state, with: "Alabama"
      fill_in :user_zip_code, with: 35622
      fill_in :user_email, with: 'joe@joecodes.com'
      fill_in :user_password, with: 'JoeIsTheCoolest'
      fill_in :user_password_confirmation, with: 'JoeIsTheCoolest'

      click_button("Update User")

      merchant_rename = User.find(merchant.id)
      expect(merchant_rename.name).to eq("CHANGE NAME")
      expect(merchant_rename.address).to eq("123 Main Street")
      expect(merchant_rename.city).to eq("Fakeville")
      expect(merchant_rename.state).to eq("Alabama")
      expect(merchant_rename.zip_code).to eq(35622)
      expect(merchant_rename.email).to eq("joe@joecodes.com")
    end

  end
end
