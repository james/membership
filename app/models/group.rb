class Group < ApplicationRecord
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

  def roleholder_memberships
    group_memberships.roleholders
  end
end
