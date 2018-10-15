FactoryBot.define do
  factory :member do
    first_name  { "Janet" }
    last_name  { "Doe" }
    sequence :email_address do |n|
      "member#{n}@example.com"
    end
    email_opt_in { true }
    is_volunteer { true }
    phone { "02083654736" }
    mobile { "07777777777" }
    mobile_opt_in { false }
    employer { "Axel Corps" }
    occupation { "Cleaner" }
    born_at { 30.years.ago }
    address1 { "Flat 3" }
    address2 { "30 Street" }
    city { "London" }
    state { "Greater London" }
    post_code { 'GB' }
    sequence :membership_id do |n|
      "MEMBER#{n}"
    end
    membership_level { 'Standard' }
  end
end
