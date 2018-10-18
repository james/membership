FactoryBot.define do
  factory :group_membership do
    member
    group
    roleholder { false }
    role_name { nil }
    can_manage_members { false }
    is_public { false }
    can_manage_group { false }
  end
end
