require 'rails_helper'

  describe 'Merchant Index Page' do

    let!(:merchants) {create_list(:user, 5, role: 1)}
    let!(:regular_users) {create_list(:user, 4)}
    let!(:admin) {create(:user, role: 2)}
    let!(:registered_user) {create(:user, role: 0)}

    context 'A Merchant' do

      before do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchants.first)
      end

      context 'Can view all merchants' do
        subject{ visit merchants_path; page}

        it {is_expected.to have_current_path(merchants_path)}
        it {is_expected.to have_selector(".merchant", count: merchants.length)}
        it {is_expected.to have_content(merchants.first.name)}
        it {is_expected.to have_content(merchants.last.name)}
      end

      context 'Cannot view the admin merchant show page' do
        subject { visit admin_merchant_path(merchants.first); page }

        it {is_expected.to have_content "The page you were looking for doesn't exist (404)"}
      end
    end

    context 'A Registered User' do

      before do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(registered_user)
      end

      context 'Can view all merchants' do
        subject{ visit merchants_path; page}

        it {is_expected.to have_current_path(merchants_path)}
        it {is_expected.to have_selector(".merchant", count: merchants.length)}
        it {is_expected.to have_content(merchants.first.name)}
        it {is_expected.to have_content(merchants.last.name)}
      end

      context 'Cannot view the admin merchant show page' do
        subject { visit admin_merchant_path(merchants.first); page }

        it {is_expected.to have_content "The page you were looking for doesn't exist (404)"}
      end
    end

  end
