class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user

  def member
    user.member
  end
end
