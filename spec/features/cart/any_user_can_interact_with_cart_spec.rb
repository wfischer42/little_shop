require 'rails_helper'

describe 'any user can interact with a cart' do
  include ActionView::Helpers::NumberHelper
  before(:each) do
    @item, @item_2 = create_list(:item, 2)
    @item.inventory_count = 4
    visit item_path(@item)
    click_on "Add to Cart"
    visit item_path(@item)
    click_on "Add to Cart"
    visit cart_path
  end

  it 'shows cart with items in it' do

    expect(current_path).to eq(cart_path)
    expect(page).to have_content(@item.name)
    expect(page).to have_content(@item.merchant.name)
    expect(page).to have_content(@item.price)
    within("td.quantity-#{@item.id}")do
      expect(page).to have_content(2)
    end
    within("td.sub-#{@item.id}")do
      expect(page).to have_content(@item.price * 2)
    end

    visit item_path(@item_2)
    click_on "Add to Cart"

    expect(current_path).to eq(cart_path)
    expect(page).to have_content(@item_2.name)
    expect(page).to have_content(@item_2.merchant.name)
    expect(page).to have_content(@item_2.price)
    within("td.quantity-#{@item_2.id}")do
      expect(page).to have_content(1)
    end
    within("td.sub-#{@item_2.id}")do
      expect(page).to have_content(@item_2.price)
    end
    expect(page).to have_content("Cart = 3")
    grand_total = (@item_2.price) + (@item.price * 2)
    expect(page).to have_content("Grand Total: #{number_to_currency(grand_total)}")

    click_on "Empty Cart"

    expect(current_path).to eq(cart_path)
    expect(page).to_not have_content(@item.name)
    expect(page).to_not have_content(@item_2.name)
    expect(page).to have_content("Your Cart Is Empty")
    expect(page).to have_content("Please add items to continue!")
    expect(page).to have_link('items')
    expect(page).to have_content("Cart = 0")
  end

  it 'lets user remove a particular item from cart' do
    visit item_path(@item_2)
    click_on "Add to Cart"
    visit cart_path
    first(:button, "Remove").click

    expect(page).to_not have_content(@item)
    expect(page).to have_content(@item_2.name)
  end
  it 'lets user decrease item quantity in the cart' do
    first(:button, "-").click

    within("td.quantity-#{@item.id}")do
      expect(page).to have_content(1)
    end

    first(:button, "-").click

    expect(page).to_not have_content(@item.name)
  end

  it 'shows checkout button for user' do
    admin =  create(:user, role: 2)
    merchant = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)
    visit cart_path

    expect(page).to have_button("Checkout")
  end

  it 'it shows register/login instead of checkout for visitor' do
    visit cart_path

    expect(page).to_not have_button("Checkout")
    expect(page).to have_link("Login")
    expect(page).to have_link("Register")

    within("p.checkout-login") do
      click_on "Login"
    end
    expect(current_path).to eq(login_path)

    visit cart_path
    within("p.checkout-register") do
      click_on "Register"
    end

    expect(current_path).to eq(register_path)
  end

  it 'clears cart on checkout' do
    merchant = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)
    visit cart_path
    click_button("checkout")
    expect(page.driver.request.session[:cart]).to be_nil
  end
end
