require 'rails_helper'

RSpec.describe 'When an admin views the merchant index page' do
  it 'sees an enable button under disabled users' do
    @admin = create(:user, role: 2)
    @merchant_1, @merchant_2, @merchant_3 = create_list(:user, 3, role: 1, active: false)
    @merchant_4 = create(:user, role:1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

    visit merchants_path

    within("#merchant_#{@merchant_1.id}") do
      expect(page).to have_button("Enable")
    end

    within("#merchant_#{@merchant_4.id}") do
      expect(page).to have_button("Disable")
    end
  end

  it 'sees a disable button under enabled users' do
    @admin = create(:user, role: 2)
    @merchant_1, @merchant_2, @merchant_3 = create_list(:user, 3, role: 1)
    @merchant_4 = create(:user, role: 1, active: false)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

    visit merchants_path

    within("#merchant_#{@merchant_1.id}") do
      expect(page).to have_button("Disable")
    end

    within("#merchant_#{@merchant_4.id}") do
      expect(page).to have_button("Enable")
    end

  end

  it 'makes a merchant disabled buy clicking the disable button' do
    admin = create(:user, role: 2)
    merchant_1, merchant_2, merchant_3 = create_list(:user, 3, role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit merchants_path

    within("#merchant_#{merchant_1.id}") do
      click_button("Disable")
    end

    merchant = User.find(merchant_1.id)
    within("#merchant_#{merchant_1.id}") do
      expect(page).to have_button("Enable")
      expect(merchant.active?).to eq(false)
    end

  end

  it 'makes a merchant enabled buy clicking the enable button' do
    admin = create(:user, role: 2)
    merchant_1, merchant_2, merchant_3 = create_list(:user, 3, role: 1, active: false)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit merchants_path

    within("#merchant_#{merchant_1.id}") do
      click_button("Enable")
    end

    merchant = User.find(merchant_1.id)

    within("#merchant_#{merchant.id}") do
      expect(page).to have_button("Disable")
      expect(merchant.active?).to eq(true)
    end

  end


end
