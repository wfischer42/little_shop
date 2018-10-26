require 'rails_helper'

describe 'user goes to profile page and updates it info' do


  it 'should go to the form' do
    user = create(:user, email: "didfjslkd")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit profile_path

    click_on 'Update Profile'

    expect(current_path).to eq(profile_edit_path)
    expect(find_field("user_name").value).to eq(user.name)
    expect(find_field("user_address").value).to eq(user.address)
    expect(find_field("user_city").value).to eq(user.city)
    expect(find_field("user_state").value).to eq(user.state)
    expect(find_field("user_zip_code").value).to eq("#{user.zip_code}")
    expect(find_field("user_password").value).to_not eq(user.password)
    expect(find_field("user_email").value).to eq(user.email)
  end
end
