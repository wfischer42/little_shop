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
  describe 'merchant stats' do
    before do
      @user_1 = create(:user)
      @user_2 = create(:user)
      @user_3 = create(:user)
      @user_4 = create(:user)

      @merchant_1 = create(:user, role: 1)
      @merchant_2 = create(:user, role: 1)
      @merchant_3 = create(:user, role: 1)
      @merchant_4 = create(:user, role: 1)
      @merchant_5 = create(:user, role: 1)
      @merchant_6 = create(:user, role: 1)
      @merchant_7 = create(:user, role: 1)

      @item_1, @item_2 = create_list(:item, 2, user: @merchant_1, price: 10000)
      @item_3, @item_4 = create_list(:item, 2, user: @merchant_2, price: 5000)
      @item_5, @item_6 = create_list(:item, 2, user: @merchant_3, price: 2500)
      @item_7, @item_8 = create_list(:item, 2, user: @merchant_4, price: 10)
      @item_9, @item_10 = create_list(:item, 2, user: @merchant_5, price: 5)
      @item_11, @item_12 = create_list(:item, 2, user: @merchant_6, price: 3)
      @item_13, @item_14 = create_list(:item, 2, user: @merchant_7, price: 1)

      @order_1, @order_2, @order_3 = create_list(:order, 3, status: 2, user: @user_1)

      @order_item_1 = create(:order_item, order: @order_1, item: @item_1, fulfilled: true, updated_at: Time.now + 2.hours, item_quantity: 9)
      @order_item_2 = create(:order_item, order: @order_1, item: @item_2, fulfilled: true, updated_at: Time.now + 2.hours, item_quantity: 9)
      @order_item_3 = create(:order_item, order: @order_1, item: @item_3, fulfilled: true, updated_at: Time.now + 3.hours, item_quantity: 11)
      @order_item_4 = create(:order_item, order: @order_1, item: @item_4, fulfilled: true, updated_at: Time.now + 3.hours, item_quantity: 11)
      @order_item_5 = create(:order_item, order: @order_1, item: @item_5, fulfilled: true, updated_at: Time.now + 4.hours, item_quantity: 12)
      @order_item_16 = create(:order_item, order: @order_1, item: @item_10, fulfilled: true, updated_at: Time.now + 6.hours, item_quantity: 10)

      @order_item_6 = create(:order_item, order: @order_2, item: @item_6, fulfilled: true, updated_at: Time.now + 4.hours, item_quantity: 12)
      @order_item_7 = create(:order_item, order: @order_2, item: @item_7, fulfilled: true, updated_at: Time.now + 5.hours, item_quantity: 15)
      @order_item_8 = create(:order_item, order: @order_2, item: @item_8, fulfilled: true, updated_at: Time.now + 5.hours, item_quantity: 15)
      @order_item_9 = create(:order_item, order: @order_2, item: @item_9, fulfilled: true, updated_at: Time.now + 6.hours, item_quantity: 10)
      @order_item_10 = create(:order_item, order: @order_2, item: @item_10, fulfilled: true, updated_at: Time.now + 6.hours, item_quantity: 10)

      @order_item_11 = create(:order_item, order: @order_3, item: @item_6, fulfilled: true, updated_at: Time.now + 4.hours, item_quantity: 10)
      @order_item_12 = create(:order_item, order: @order_3, item: @item_7, fulfilled: true, updated_at: Time.now + 5.hours, item_quantity: 15)
      @order_item_13 = create(:order_item, order: @order_3, item: @item_8, fulfilled: true, updated_at: Time.now + 5.hours, item_quantity: 15)
      @order_item_14 = create(:order_item, order: @order_3, item: @item_9, fulfilled: true, updated_at: Time.now + 6.hours, item_quantity: 20)
      @order_item_15 = create(:order_item, order: @order_3, item: @item_10, fulfilled: true, updated_at: Time.now + 6.hours, item_quantity: 20)

    end

    it '#most_popular_merchants' do
      expect(User.most_popular_merchants).to eq([@merchant_5, @merchant_4, @merchant_3, @merchant_2, @merchant_1])
    end

    it '#fastest_merchants' do
      expect(User.fastest_merchants).to eq([@merchant_1, @merchant_2, @merchant_3])
    end

    it '#slowest_merchants' do
      expect(User.slowest_merchants).to eq([@merchant_5, @merchant_4, @merchant_3])
    end

    it '#top_selling_merchants' do
      expect(User.top_selling_merchants).to eq([@merchant_1, @merchant_2, @merchant_3])
    end
  end

  describe '#biggest_spenders' do
    let(:orders)   { create_list(:order, 5) }

    before do
      extra_order = create(:order, user: orders[0].user)
      create(:order_item, order: orders[0], fulfilled: true, item_price: 10, item_quantity: 17)
      create(:order_item, order: orders[1], fulfilled: true, item_price: 190, item_quantity: 1)
      create(:order_item, order: orders[2], fulfilled: true, item_price: 30, item_quantity: 2)
      create(:order_item, order: orders[2], fulfilled: true, item_price: 60, item_quantity: 2)
      create(:order_item, order: orders[3], fulfilled: true, item_price: 40, item_quantity: 1)
      create(:order_item, order: orders[4], fulfilled: true, item_price: 50, item_quantity: 1)
      create(:order_item, order: orders[4], fulfilled: false, item_price: 60, item_quantity: 10)
    end

    subject(:result) do
      User.biggest_spenders.map do |user|
        user.name
      end
    end

    let(:expected) { [orders[1].user.name, orders[2].user.name, orders[0].user.name] }

    it { should eq expected }
  end

end

  describe ' Instance Methods' do
    before do
      @admin = create(:user, role: 2)
      @user_1 = User.create(name: "Hola", address: "1234 Long St", city: "Denver", state: "CO", zip_code: 74234, email: "1345@fake.com", password: "1234321", role: 0)
      @user_2 = User.create(name: "adios", address: "12 Short St", city: "Boulder", state: "CO", zip_code: 73943, email: "9876@fake.com", password: "1234", role: 0)
      @user_3 = User.create(name: "Buenas", address: "1234 middle St", city: "Atlanta", state: "GA", zip_code: 90211, email: "2510@fake.com", password: "12233", role: 0)
      @user_4 = User.create(name: "Chevere", address: "13 Diagon St", city: "New York", state: "NY", zip_code: 37483, email: "5002@fake.com", password: "12233", role: 0)

      @merc_1 = create(:user, name: "El Vago", role: 1)
      @merc_2 = User.create(name: "Merc_2", address: "12 Short St", city: "Boulder", state: "CO", zip_code: 73943, email: "merc_2fake.com", password: "1234", role: 1)
      @merc_3 = User.create(name: "Merc_3", address: "1234 middle St", city: "Atlanta", state: "GA", zip_code: 91211, email: "merc_3@fake.com", password: "12233", role: 1)
      @merc_4 = User.create(name: "Merc_4", address: "13 Diagon St", city: "New York", state: "NY", zip_code: 37483, email: "merc_4@fake.com", password: "12233", role: 1)

      @item_1 = create(:item, user: @merc_1)
      @item_3 = create(:item, user: @merc_2)
      @item_5 = create(:item, user: @merc_3)
      @item_7 = create(:item, user: @merc_4)
      @item_2 = create(:item, user: @merc_1)
      @item_4 = create(:item, user: @merc_1)
      @item_6 = create(:item, user: @merc_2)
      @item_8 = create(:item, user: @merc_3)
      @item_9 = create(:item, user: @merc_3)
      @item_10 = create(:item, user: @merc_1)

      @order_1 = create(:order, status: 2, user: @user_1)
      @order_2 = create(:order, status: 1, user: @user_2)
      @order_3 = create(:order, status: 0, user: @user_3)
      @order_4 = create(:order, status: 1, user: @user_4)
      @order_5 = create(:order, status: 2, user: @user_1)
      @order_6 = create(:order, status: 2, user: @user_4)

      @order_item_1 = create(:order_item, order: @order_1, item: @item_1)
      @order_item_2 = create(:order_item, order: @order_1, item: @item_2)
      @order_item_3 = create(:order_item, order: @order_5, item: @item_3)
      @order_item_4 = create(:order_item, order: @order_1, item: @item_4)
      @order_item_5 = create(:order_item, order: @order_1, item: @item_5)
      @order_item_6 = create(:order_item, order: @order_2, item: @item_1)
      @order_item_7 = create(:order_item, order: @order_2, item: @item_2)
      @order_item_8 = create(:order_item, order: @order_4, item: @item_3)
      @order_item_9 = create(:order_item, order: @order_3, item: @item_4)
      @order_item_10 = create(:order_item, order: @order_3, item: @item_6)
      @order_item_11 = create(:order_item, order: @order_1, item: @item_7)
      @order_item_12 = create(:order_item, order: @order_6, item: @item_8)
      @order_item_13 = create(:order_item, order: @order_6, item: @item_9)
      @order_item_14 = create(:order_item, order: @order_4, item: @item_10)
      @order_item_15 = create(:order_item, order: @order_3, item: @item_7)
      @order_item_16 = create(:order_item, order: @order_4, item: @item_1)
      @order_item_17 = create(:order_item, order: @order_3, item: @item_6)
      @order_item_18 = create(:order_item, order: @order_1, item: @item_8)
      @order_item_19 = create(:order_item, order: @order_1, item: @item_6)
      @order_item_20 = create(:order_item, order: @order_2, item: @item_9)
    end

    describe 'Merchants get its item orders from customers' do
      subject {@merc_1.merchant_orders}

      it{ is_expected.to eq([@order_1, @order_1, @order_1, @order_2, @order_2, @order_3, @order_4, @order_4])}
    end

  end
