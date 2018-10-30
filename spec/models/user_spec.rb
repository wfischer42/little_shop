require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_secure_password }
  it { is_expected.to validate_presence_of(:name)}
  it { is_expected.to validate_presence_of(:password)}
  it { is_expected.to validate_presence_of(:email)}
  it { is_expected.to validate_presence_of(:address)}
  it { is_expected.to validate_presence_of(:city)}
  it { is_expected.to validate_presence_of(:state)}
  it { is_expected.to validate_presence_of(:zip_code)}
  it { is_expected.to validate_presence_of(:role)}
  it { is_expected.to validate_uniqueness_of(:email)}
  it { is_expected.to validate_numericality_of(:zip_code)}
  it { is_expected.to have_many(:orders)}
  it { is_expected.to have_many(:items)}
  it { expect(subject.role).to eq("customer") }

  before do
    @user_1 = create(:user)
    @merchant_1 = create(:user, role: 1)
    @merchant_2 = create(:user, role: 1)
    @merchant_3 = create(:user, role: 1)
    @merchant_4 = create(:user, role: 1)
    @merchant_5 = create(:user, role: 1)
    @merchant_6 = create(:user, role: 1)
    @merchant_7 = create(:user, role: 1)

    @item_1, @item_2 = create_list(:item, 2, user: @merchant_1)
    @item_3, @item_4 = create_list(:item, 2, user: @merchant_2)
    @item_5, @item_6 = create_list(:item, 2, user: @merchant_3)
    @item_7, @item_8 = create_list(:item, 2, user: @merchant_4)
    @item_9, @item_10 = create_list(:item, 2, user: @merchant_5)

    @order_1, @order_2, @order_3 = create_list(:order, 3, status: 2, user: @user_1)

    @order_item_1 = create(:order_item, order: @order_1, item: @item_1, fulfilled: true, updated_at: Time.now + 2.hours)
    @order_item_2 = create(:order_item, order: @order_1, item: @item_2, fulfilled: true, updated_at: Time.now + 2.hours)
    @order_item_3 = create(:order_item, order: @order_1, item: @item_3, fulfilled: true, updated_at: Time.now + 3.hours)
    @order_item_4 = create(:order_item, order: @order_1, item: @item_4, fulfilled: true, updated_at: Time.now + 3.hours)
    @order_item_5 = create(:order_item, order: @order_1, item: @item_5, fulfilled: true, updated_at: Time.now + 4.hours)
    @order_item_16 = create(:order_item, order: @order_1, item: @item_10, fulfilled: true, updated_at: Time.now + 6.hours)

    @order_item_6 = create(:order_item, order: @order_2, item: @item_6, fulfilled: true, updated_at: Time.now + 4.hours)
    @order_item_7 = create(:order_item, order: @order_2, item: @item_7, fulfilled: true, updated_at: Time.now + 5.hours)
    @order_item_8 = create(:order_item, order: @order_2, item: @item_8, fulfilled: true, updated_at: Time.now + 5.hours)
    @order_item_9 = create(:order_item, order: @order_2, item: @item_9, fulfilled: true, updated_at: Time.now + 6.hours)
    @order_item_10 = create(:order_item, order: @order_2, item: @item_10, fulfilled: true, updated_at: Time.now + 6.hours)

    @order_item_11 = create(:order_item, order: @order_3, item: @item_6, fulfilled: true, updated_at: Time.now + 4.hours)
    @order_item_12 = create(:order_item, order: @order_3, item: @item_7, fulfilled: true, updated_at: Time.now + 5.hours)
    @order_item_13 = create(:order_item, order: @order_3, item: @item_8, fulfilled: true, updated_at: Time.now + 5.hours)
    @order_item_14 = create(:order_item, order: @order_3, item: @item_9, fulfilled: true, updated_at: Time.now + 6.hours)
    @order_item_15 = create(:order_item, order: @order_3, item: @item_10, fulfilled: true, updated_at: Time.now + 6.hours)
  end

  it '.most_popular_merchants' do
    expect(User.most_popular_merchants).to eq([@merchant_5, @merchant_4, @merchant_3, @merchant_2, @merchant_1])
  end

  it '.fastest_merchants' do
    expect(User.fastest_merchants).to eq([@merchant_1, @merchant_2, @merchant_3])
  end
end
