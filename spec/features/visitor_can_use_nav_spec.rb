require 'rails_helper'

describe 'nav bar' do
  context 'for all visitors' do
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

  context 'for logged in user' do
    before do
      user = create(:user, email: "didfjslkd")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit root_path
    end
    context 'there is no login or register link' do
      subject { page }
      it { is_expected.to_not have_content("Login")}
      it { is_expected.to_not have_content("Register")}
    end
    context 'Profile Link' do
      subject { click_link "Profile"; page }
      it { is_expected.to have_current_path(profile_path) }
    end
    context 'Orders Link' do
      subject { click_link "Orders"; page}
      it { is_expected.to have_current_path(profile_orders_path) }
    end
    context 'Logout' do
      subject { click_link "Logout"; page}
      it { is_expected.to have_current_path(root_path) }
      context 'Session user ID' do
        scenario { expect(page.driver.request.session[:user_id]).to be_nil}
      end
      context 'Session cart' do
        scenario { expect(page.driver.request.session[:cart]).to be_nil}
      end
    end
  end
end
