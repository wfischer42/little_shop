# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def seed_user(role: :customer)
  User.create(name: Faker::Name.unique.name,
              address: Faker::Address.street_address,
              city: Faker::Address.city,
              state: Faker::Address.state_abbr,
              zip_code: Faker::Address.zip_code,
              email: Faker::Internet.unique.email,
              password: Faker::String.random(10..20),
              role: role)
end

def seed_item
  merchant = @merchants.sample
  Item.create(name: Faker::Lorem.sentence(1,true,2),
              description: Faker::Lorem.paragraph(1,true,2),
              merchant: merchant,
              price: Faker::Number.decimal(2),
              inventory_count: Faker::Number.between(1,1000),
              img_url: Faker::LoremFlickr.image("100x100"))
end

def seed_order
  number_of_items = rand(1..6)
  new_items = @items.sample(number_of_items)
  customer = @customers.sample
  order = Order.create(user: customer)
  rand(1..6).times do
    item = @items.sample
    order.order_items.create(item: item,
                             item_quantity: rand(1..10),
                             item_price: item.price)
  end
end

def add_login_paths
  User.find_by(role: :admin).update(email: "admin", password: "admin")
  User.find_by(role: :merchant).update(email: "merchant", password: "merchant")
  User.find_by(role: :customer).update(email: "customer", password: "customer")
end

4.times  { seed_user(role: :admin) }
10.times { seed_user(role: :customer) }
10.times  { seed_user(role: :merchant) }

@customers = User.where(role: :customer)
@merchants = User.where(role: :merchant)
@admins = User.where(role: :admin)

30.times { seed_item }
@items = Item.all
100.times { seed_order }

add_login_paths
