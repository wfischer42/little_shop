require 'rails_helper'

describe 'nav bar' do

  before { visit root_path }

  context 'Items link' do
    subject { click_link "Items"; page }
    it { is_expected.to have_current_path(items_path) }
  end

  context 'Merchants link' do
    subject { click_link "Merchants"; page }
    it { is_expected.to have_current_path(merchants_path) }
  end

  context 'Cart link' do
    subject { click_link "Cart"; page }
    it { is_expected.to have_current_path(cart_path) }
  end

  context 'Login Link' do
    subject { click_link "Login"; page }
    it { is_expected.to have_current_path(login_path) }
  end

  context 'Register Link' do
    subject { click_link "Register"; page }
    it { is_expected.to have_current_path(register_path) }
  end

  context 'Home' do
    subject do
      visit items_path
      click_link "LittleShop"; page
    end
    it { is_expected.to have_current_path(root_path) }
  end
end
