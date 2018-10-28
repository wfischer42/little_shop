require 'rails_helper'

describe 'User Sign in' do
  before(:each) do
    @customer = create(:user, name: "kaka")
    @merchant = create(:user,  role: :merchant)
    @admin    = create(:user,  role: :admin)
  end

  context 'As customer logged user if you visit log path you go to your profile page' do
    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@customer)
      visit login_path
    end

    subject {page}

    it {is_expected.to have_current_path(profile_path) }
    it {is_expected.to have_content("User is already logged in") }
  end

  context 'As admin logged user if you visit log path you go to your profile page' do
    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit login_path
    end

    subject {page}

    it {is_expected.to have_current_path(profile_path) }
    it {is_expected.to have_content("User is already logged in") }
  end
end
