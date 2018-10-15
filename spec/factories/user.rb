FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "user#{n}@example.com"
    end
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Time.now }
  end
end
