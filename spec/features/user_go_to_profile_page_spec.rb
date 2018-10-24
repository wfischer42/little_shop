require 'rails_helper'

describe 'User (customer,merchant,admin) and can see profile' do

  before do
    @user_1 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

    visit profile_path
  end

  context 'profile page' do
    it { is_expected.to current_path(profile_path) }
    it { is_expected.to have_http_status(200)}

    it { is_espected.to have_content(@user_1.name) }
    it { is_espected.to have_content(@user_1.address) }
    it { is_espected.to have_content(@user_1.state) }
    it { is_espected.to have_content(@user_1.zip_code) }
    it { is_espected.to have_content(@user_1.email) }
    it { is_espected.to_not have_content(@user_1.password) }

    context 'stats' do
      it { is_expected.to have_content(@user_1.created_at.year)}
    end
  end

  context 'Links to Order show page' do
    subject {click_on ".order_page_link"; page}
    
    it { is_expected.to have_current_path(user_orders_path(@user_1))}
    it { is_expected.to have_http_status(200)}
  end

end
