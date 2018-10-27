require 'rails_helper'

describe 'admin visits user index page' do
  before do
    user_1 = create(:user)
    user_2 = create(:user)
    user_3 = create(:user)
    user_4 = create(:user)
    admin = create(:user, role: 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_users_path
  end

  it 'sees all registered users' do

  end
end
