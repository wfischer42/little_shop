require 'rails_helper'

describe 'User Sign in' do
  before(:each) do
    @password = "abcdefg"
    @customer = create(:user, password: @password)
    @merchant = create(:user, password: @password, role: :merchant)
    @admin    = create(:user, password: @password, role: :admin)
    visit login_path
    fill_in 'password', with: @password
  end

  context 'with valid customer credentials' do
    before do
      fill_in 'email', with: @customer.email
      click_on 'Sign in'
    end

    subject { page }
    it { is_expected.to have_current_path(profile_path) }

    describe 'current user' do
      subject { page.driver.request.session[:user_id] }
      it { is_expected.to eq(@customer.id)}
    end
  end

  context 'with valid merchant credentials' do
    before do
      fill_in 'email', with: @merchant.email
      click_on 'Sign in'
    end

    subject { page }
    it { is_expected.to have_current_path(dashboard_path) }

    describe 'current user' do
      subject { page.driver.request.session[:user_id] }
      it { is_expected.to eq(@merchant.id)}
    end
  end

  context 'with invalid credentials' do
    let(:warning) { "The email address or password you entered was incorrect" }
    before do
      fill_in 'email', with: @customer.email
      fill_in 'password', with: "1234"
      click_on 'Sign in'
    end
    subject { page }
    it { is_expected.to have_content(warning)}
  end
end
