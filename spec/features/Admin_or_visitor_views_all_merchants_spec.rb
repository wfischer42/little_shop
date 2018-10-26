require 'rails_helper'

  describe 'Merchant Index Page' do

    let!(:merchants) {create_list(:user, 5, role: 1)}
    let!(:regular_users) {create_list(:user, 4)}
    let!(:admin) {create(:user, role: 2)}
    let!(:registered_user) {create(:user, role: 0)}

    context 'A visitor' do

      before do
        visit merchants_path
      end

      context 'Can view all merchants' do

        subject {page}

        it {is_expected.to have_current_path(merchants_path)}
        it {is_expected.to have_selector(".merchant", count: merchants.length)}
        it {is_expected.to have_content(merchants.first.name)}
        it {is_expected.to have_content(merchants.last.name)}
      end

      context 'Does not see regular users' do
        subject {page}
        it {is_expected.to_not have_content(regular_users.first.name)}
        it {is_expected.to_not have_content(regular_users.last.name)}
      end
    end

    context 'An admin' do

      before do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
        visit admin_merchants_path
      end

      context 'Can view all merchants' do

        subject { page }

        it {is_expected.to have_current_path(admin_merchants_path)}
        it {is_expected.to have_selector(".merchant", count: merchants.length)}
        it {is_expected.to have_content(merchants.first.name)}
        it {is_expected.to have_content(merchants.last.name)}
      end

      context 'Does not see regular users' do
        subject {page}
        it {is_expected.to_not have_content(regular_users.first.name)}
        it {is_expected.to_not have_content(regular_users.last.name)}
      end

      context 'Sees merchant names link to merchant profile pages' do
        subject { click_link merchants.first.name; page }

        it {is_expected.to have_current_path(admin_merchant_path(merchants.first))}
      end

    end

  end
