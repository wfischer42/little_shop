require 'rails_helper'

describe 'Admin goes to user profile page' do
  before do
    @admin =  create(:user, role: 2)
    @user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    visit admin_user_path(@user)
  end

  it 'can upgrade a user to a merchant' do
    click_button("Upgrade Account")
    @user_rename = User.find(@user.id)
    expect(@user_rename.role).to eq('merchant')
    expect(current_path).to eq(admin_merchant_path(@user_rename))
  end

  it 'sees a button to edit profile information and button takes you to an update form' do
    click_link("Edit Profile Information")
    expect(current_path).to eq(edit_admin_user_path(@user))
    expect(page).to have_button("Update User")
  end

  it 'can change and save user information' do
    click_link("Edit Profile Information")

    fill_in :user_name, with: "CHANGE NAME"
    fill_in :user_address, with: "123 Main Street"
    fill_in :user_city, with: "Fakeville"
    fill_in :user_state, with: "Alabama"
    fill_in :user_zip_code, with: 35622
    fill_in :user_email, with: 'joe@joecodes.com'
    fill_in :user_password, with: 'JoeIsTheCoolest'
    fill_in :user_password_confirmation, with: 'JoeIsTheCoolest'
    click_button("Update User")

    user_rename = User.find(@user.id)

    expect(user_rename.name).to eq("CHANGE NAME")
    expect(user_rename.address).to eq("123 Main Street")
    expect(user_rename.city).to eq("Fakeville")
    expect(user_rename.state).to eq("Alabama")
    expect(user_rename.zip_code).to eq(35622)
    expect(user_rename.email).to eq("joe@joecodes.com")
  end

  it 'cannot save changes if changes are invalid (same email)' do
    @admin =  create(:user, role: 2)
    @user_1 = create(:user, role: 1)
    @user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

    visit edit_admin_user_path(@user)

    fill_in :user_name, with: "CHANGE NAME"
    fill_in :user_address, with: "123 Main Street"
    fill_in :user_city, with: "Fakeville"
    fill_in :user_state, with: "Alabama"
    fill_in :user_zip_code, with: 35622
    fill_in :user_email, with: @user_1.email
    fill_in :user_password, with: 'JoeIsTheCoolest'
    fill_in :user_password_confirmation, with: 'JoeIsTheCoolest'

    click_button("Update User")

    expect(page).to have_content("Error")
  end

  describe 'only admin can view profile page routes' do
    it 'a customer gets 404 error when trying to view admin user path' do
      user =  create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit admin_user_path(user)

      expect(page).to have_content("404")
    end

    it 'a merchant gets 404 error when trying to view admin user path' do
      user =  create(:user)
      merchant = create(:user, role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)
      visit admin_user_path(user)

      expect(page).to have_content("404")
    end
  end

end
