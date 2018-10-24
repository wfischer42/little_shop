require 'rails_helper'

describe 'nav bar' do

  before { visit root_path }

  context 'Items link' do
    subject { click_link "Items"; page }
    it { is_expected.to have_current_path(items_path) }
    it { is_expected.to have_content("All Items") }
    it { is_expected.to have_http_status(200) }
  end

  context 'Merchants link' do
    subject { click_link "Merchants"; page }
    it { is_expected.to have_current_path(merchants_path) }
    it { is_expected.to have_content("All Merchants") }
    it { is_expected.to have_http_status(200) }
  end

  context 'Cart link' do
    subject { click_link "Cart"; page }
    it { is_expected.to have_current_path(cart_path) }
    it { is_expected.to have_content("Your Cart") }
    it { is_expected.to have_http_status(200) }
  end

  context 'Login Link' do
    subject { click_link "Login"; page }
    it { is_expected.to have_current_path(login_path) }
    it { is_expected.to have_content("Log in to see more") }
    it { is_expected.to have_http_status(200) }
  end

  context 'Register Link' do
    subject { click_link "Register"; page }
    it { is_expected.to have_current_path(register_path) }
    it { is_expected.to have_content("Sign up to see more") }
    it { is_expected.to have_http_status(200) }
  end

  context 'Home' do
    subject do
      visit items_path
      click_link "LittleShop"; page
    end
    it { is_expected.to have_current_path(root_path) }
    it { is_expected.to have_content("Welcome To LittleShop") }
    it { is_expected.to have_http_status(200) }
  end
end
