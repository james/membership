class User < ApplicationRecord
  belongs_to :member
  has_many :group_memberships, through: :member
  has_many :groups, through: :member
  before_create :find_or_create_member

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  def admin?
    role == 'admin'
  end

  def viewable_groups
    Group.all
  end

  def viewable_groups_excluding_joined
    viewable_groups - member.groups
  end

  def membership_for(group)
    self.member.group_memberships.where(group: group).first
  end

  def member_of?(group)
    !!membership_for(group)
  end

  def name_or_email
    if member.present? && member.full_name.present?
      member.full_name
    else
      email
    end
  end

  def can_manage_members_of?(group)
    admin? || (membership_for(group) && membership_for(group).can_manage_members?)
  end

  def is_roleholder_of?(group)
    admin? || (membership_for(group) && membership_for(group).roleholder?)
  end

  private
  def find_or_create_member
    self.member = Member.find_or_create_by(email_address: self.email)
  end
end
