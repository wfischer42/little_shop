require 'rails_helper'

describe 'admin visits user index page' do
  before do
    @user_1 = create(:user)
    @user_2 = create(:user)
    @user_3 = create(:user)
    @user_4 = create(:user)
    @user_5 = create(:user, active: false)
    @admin = create(:user, role: 2)
    @merchant = create(:user, role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

    visit admin_users_path
  end

  it 'sees all registered users and no merchants' do
    expect(page).to have_content(@user_1.name)
    expect(page).to have_content(@user_2.name)
    expect(page).to have_content(@user_3.name)
    expect(page).to have_content(@user_4.name)
    expect(page).to_not have_content(@merchant.name)
  end

  it 'users full name is a link to their respective show page' do
    within("#user_#{@user_1.id}") do
      expect(page).to have_link(@user_1.name)
    end

    within("#user_#{@user_1.id}") do
      click_link(@user_1.name)
      expect(current_path).to eq(admin_user_path(@user_1))
    end

  end

  it 'disable button next to enabled users' do
    within("#user_#{@user_1.id}") do
      expect(page).to have_button("Disable")
    end
  end

  it 'enable button next to disabled users' do
    within("#user_#{@user_5.id}") do
      expect(page).to have_button("Enable")
    end
  end

  it 'can enable users who are disabled' do
    within("#user_#{@user_5.id}") do
      click_button("Enable")
      user_5 = User.find(@user_5.id)
      expect(user_5.active?).to eq(true)
    end
  end

  it 'sees a successful flash message when user is enabled' do
    within("#user_#{@user_5.id}") do
      click_button("Enable")
    end
    expect(page).to have_content("#{@user_5.name} is now active.")
  end

  it 'can disable users who are enabled' do
    within("#user_#{@user_1.id}") do
      click_button("Disable")
      user_1 = User.find(@user_1.id)
      expect(user_1.active?).to eq(false)
    end
  end

  it 'sees a successful flash message when user is disabled' do
    within("#user_#{@user_1.id}") do
      click_button("Disable")
    end
    expect(page).to have_content("#{@user_1.name} is now inactive.")
  end
end
