require 'rails_helper'

describe 'user goes to profile page and updates it info' do
  before do
    @user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit profile_path

    click_on 'Update Profile'
  end
  
  subject{page}

  it { is_expected.to have_current_path(profile_edit_path) }
  it { is_expected.to have_content(@user.name) }
  it { is_expected.to have_content(@user.address) }
  it { is_expected.to have_content(@user.city) }
  it { is_expected.to have_content(@user.zip_code) }
  it { is_expected.to have_content(@user.email) }
  it { is_expected.to_not have_content(@user.password) }


end
