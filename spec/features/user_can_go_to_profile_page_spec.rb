require 'rails_helper'

describe 'User (customer,merchant,admin) can see profile' do

  before do
    @user_1 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

    visit profile_path
  end

  subject{page}

  context 'profile page' do
    it { is_expected.to have_current_path(profile_path) }
    it { is_expected.to have_http_status("200")}

    it { is_expected.to have_content(@user_1.name) }
    it { is_expected.to have_content(@user_1.address) }
    it { is_expected.to have_content("#{@user_1.city}, #{@user_1.state}, #{@user_1.zip_code}") }
    it { is_expected.to have_content(@user_1.email) }
    it { is_expected.to_not have_content(@user_1.password) }

    context 'stats' do
      it { is_expected.to have_content(@user_1.created_at.year)}
    end
  end

  context 'Links to Order show page' do
    subject {click_on "View Orders"; page}
    it { is_expected.to have_current_path(profile_orders_path)}
  end

end
