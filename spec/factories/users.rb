FactoryBot.define do
  factory :user do
    name { "MyString" }
    address { "MyString" }
    city { "MyString" }
    state { "MyString" }
    zip_code { 1 }
    email { "MyString" }
    password_digest { "MyString" }
    role { 1 }
    active { false }
  end
end
