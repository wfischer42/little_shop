require 'rails_helper'

  describe 'Merchant Index Page' do

    let!(:merchants) {create_list(:user, 5, role: 1)}
    let!(:regular_users) {create_list(:user, 4)}

    before do
      visit merchants_path
    end

    context 'View all merchants' do
      subject {page}
      it {is_expected.to have_current_path(merchants_path)}
      it {is_expected.to have_selector(".merchant", count: merchants.length)}
    end

    context 'Regular users do not appear' do
      subject {page}
      it {is_expected.to_not have_content(regular_users.first.name)}
      it {save_and_open_page}
    end
  end
