class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user

  def person
    user.person
  end
end
