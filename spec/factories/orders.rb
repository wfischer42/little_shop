FactoryBot.define do
  factory :order do
    status { 1 }
    sequence :total { |n| (n + 0.01).to_s }
    user
  end
end
