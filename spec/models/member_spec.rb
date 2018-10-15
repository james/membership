require 'rails_helper'

RSpec.describe Member, type: :model do
  describe '.with_account' do
    it "should filter members that have an account" do
      member1 = create :member, email_address: 'member_1@example.com'
      member2 = create :member, email_address: 'member_2@example.com'
      member3 = create :member, email_address: 'member_3@example.com'
      create :user, email: 'member_1@example.com'
      expect(Member.with_account.all).to include(member1)
      expect(Member.with_account.all).to_not include(member2)
      expect(Member.with_account.all).to_not include(member3)
    end
  end
end
