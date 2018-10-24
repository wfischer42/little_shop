# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user_1 = User.create(name: "Amy", email: "amy@gmail.com", address: "123 Main St", city: "Denver", state: "CO", zip_code: 12345, password: "12345", role: 1)

user_2 = User.create(name: "Luke", email: "luke@gmail.com", address: "123 Main St", city: "Denver", state: "CO", zip_code: 12345, password: "12345", role: 1)

user_3 = User.create(name: "Nick", email: "nick@gmail.com", address: "123 Main St", city: "Denver", state: "CO", zip_code: 12345, password: "12345", role: 1)
