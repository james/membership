FactoryBot.define do
  factory :group do
    name { 'Factory Group' }
    filter { nil }
    description { 'This group was created by Factory' }
    automatic_update { true }
    joinable { true }
    leavable { true }
  end
end
