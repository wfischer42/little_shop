require 'rails_helper'

describe 'Merchant Dashbord Page' do
  include ActionView::Helpers::NumberHelper
  # As a merchant
  # When I visit my dashboard I see an area with stats:
  # -Total items I've sold and a percentage against total remaining inventory
  # => (total item count with the current inventory plus sold items)
  #     Total Items/(Total Items + Current Inventory)?
  # -Top 3 states where my items were shipped
  # -Top 3 cities in each state where my items were shipped
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
      visit dashboard_path
    end

    it "shows total items sold" do
      expect(merchant.total_items_sold).to eq(42)
    end
    it "Shows a percentage of items sold against remaining inventory" do
      total = merchant.total_items_sold
      pct = (total.to_f * 100) / (total + merchant.total_inventory)
      pct_str = number_to_percentage(pct, precision: 1)
      expect(page).to have_content("Total items sold: #{total}")
      expect(page).to have_content("Percent against inventory: #{pct_str}")
    end
    it "shows top 3 states where items were shipped" do
      states = merchant.top_states
      within('.top_3_states') do
        expect(all('.li')[0]).to have_content("#{states[0][0]}")
        expect(all('.li')[1]).to have_content("#{states[1][0]}")
        expect(all('.li')[2]).to have_content("#{states[2][0]}")
      end
    end
    it "shows top 3 cities where items were shipped" do
      cities = merchant.top_cities
      within('.top_3_cities') do
        expect(all('.li')[0]).to have_content("#{cities[0][0]}")
        expect(all('.li')[1]).to have_content("#{cities[1][0]}")
        expect(all('.li')[2]).to have_content("#{cities[2][0]}")
      end
    end
    it "shows top 3 customers" do
      customers = merchant.top_customers
      within('.top_3_customers') do
        expect(all('.li')[0]).to have_content("#{customers[0][0]}")
        expect(all('.li')[1]).to have_content("#{customers[1][0]}")
        expect(all('.li')[2]).to have_content("#{customers[2][0]}")
      end
    end
    it "shows most active user who has ordered from me" do
      customer = merchant.most_active_customer
      expect(page).to have_content("Most active customer who has purchased from your store: #{customer[0][0]}")
    end
    it "shows largest order (by quantity of this merchants orders)" do
      order = merchant.largest_order
      expect(page).to have_content("Largest order from store: #{order.id}")
    end
    after(:all) do
      DatabaseCleaner.clean
    end
  end
end
