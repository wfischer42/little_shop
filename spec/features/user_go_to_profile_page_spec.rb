require 'rails_helper'

describe 'User (customer,merchant,admin) and can see profile' do

  before do
    @user_1 = create(:user)
    @user_2 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_2)

    visit profile_path(@user_1)
  end

  context 'profile page' do
    it { is_expected.to current_path(profile_path(@user_1)) }
    it { is_expected.to_not current_path(profile_path(@user_1)) }

    it { is_espected.to have_content(@user_1.name) }
    it { is_espected.to have_content(@user_1.address) }
    it { is_espected.to have_content(@user_1.state) }
    it { is_espected.to have_content(@user_1.zip_code) }
    it { is_espected.to have_content(@user_1.email) }
    it { is_espected.to_not have_content(@user_1.password) }
  end

  context 'Links to other parts of site' do
    
  end

end
