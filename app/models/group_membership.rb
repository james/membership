class GroupMembership < ApplicationRecord
  belongs_to :group
  belongs_to :member

  scope :roleholders, -> { where(roleholder: true) }
end
