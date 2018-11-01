require 'rails_helper'

describe 'Merchant Dashbord Page' do

  # As a merchant
  # When I visit my dashboard I see an area with stats:
  # -Total items I've sold and a percentage against total remaining inventory (total item count with be current inventory plus sold items)
  # -Top 3 states where my items were shipped
  # -Top 3 cities in each stat where my items were shipped
  # -Most active user who has ordered items from me
  # -Largest order (by quantity of items of mine)
  # -Top 3 biggest spending users who have bought my items

  describe 'Statistics' do
    before(:all) do
      merchant = create(:user, role: :merchant)
      users = create_list(:user, 4)
      7.times do |n|
        create(:order_item,
               item: create(:item, user: merchant, price: (6 - n)),
               item_price: (6 - n),
               item_quantity: (n + 3),
               fulfilled: true,
               order: create(:order, user: users[(n % 3)]))
      end
    end

    let(:merchant) { User.first}
    before do
      allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(merchant)
    end

    it "shows total items sold" do
      # binding.pry
      expect(merchant.total_items_sold).to eq(42)
    end
    xit "Shows a percentage of items sold against remaining inventory" do
    end
    xit "shows top 3 states where items were shipped" do

    end
    xit "shows top 3 cities where items were shipped" do
    end
    xit "shows top 3 customers" do
    end
    xit "shows most active user who has ordered from me" do
    end
    xit "shows largest order (by quantity of this merchants orders)" do
    end
    after(:all) do
      # Just to test before/after all setups
      DatabaseCleaner.clean
    end
  end
end
