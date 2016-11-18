class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  has_many :group_memberships, dependent: :destroy
  has_many :people, through: :group_memberships
  has_many :mailouts

  def people_by_filter
    Person.filterrific_find(self.filter_params)
  end
  def filter_params
    Filterrific::ParamSet.new(Person, JSON.parse(self.filter))
  end

  def update_memberships
    self.people = people_by_filter
  end
end
