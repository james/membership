class Group < ApplicationRecord
  has_many :group_users
  accepts_nested_attributes_for :group_users, reject_if: :all_blank, allow_destroy: true
  has_many :users, through: :group_users
  has_many :group_memberships, dependent: :destroy
  has_many :members, through: :group_memberships
  has_many :mailouts

  def members_by_filter
    Member.filterrific_find(self.filter_params)
  end
  def filter_params
    Filterrific::ParamSet.new(Member, JSON.parse(self.filter))
  end

  def update_memberships
    if filter?
      self.members = members_by_filter
    end
  end
end
