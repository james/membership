class User < ApplicationRecord
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :group_memberships, through: :groups
  has_many :members, through: :group_memberships
  belongs_to :member
  before_create :find_or_create_member

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  def admin?
    role == 'admin'
  end

  def viewable_members
    if admin?
      Member.all
    else
      members
    end
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

  private
  def find_or_create_member
    self.member = Member.find_or_create_by(email_address: self.email)
  end
end
