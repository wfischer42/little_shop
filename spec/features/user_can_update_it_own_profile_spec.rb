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

    fill_in :user_name, with: "Joe"
    fill_in :user_address, with: "123 Main Street"
    fill_in :user_city, with: "Fakeville"
    fill_in :user_state, with: "Alabama"
    fill_in :user_zip_code, with: 35622
    fill_in :user_email, with: 'joe@joecodes.com'
    fill_in :user_password, with: 'JoeIsTheCoolest'
    fill_in :user_password_confirmation, with: 'JoeIsTheCoolest'

    click_on 'Update User'

    expect(current_path).to eq(profile_path)

    expect(page).to have_content("User information Updated")
    expect(page).to have_content("Joe")
    expect(page).to have_content('joe@joecodes.com')
    expect(page).to have_content("123 Main Street")
    expect(page).to have_content("Fakeville, Alabama, 35622")

  end
end
