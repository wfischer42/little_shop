FactoryBot.define do
  factory :user do
    sequence :name        { |n| "User #{n}"}
    sequence :address     { |n| "Address #{n}" }
    sequence :city        { |n| "City #{n}" }
    sequence :state       { |n| "State #{n}" }
    sequence :zip_code    { |n| n }
    sequence :email       { |n| "Email #{n}" }
    sequence :password    { |n| "Password #{n}" }
    sequence :created_at  { |n| n.day.ago }
    role                  { 0 }
    active                { true }
  end
end
