class User < ApplicationRecord
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :group_memberships, through: :groups
  has_many :people, through: :group_memberships
  belongs_to :person
  before_create :find_or_create_person

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  def admin?
    role == 'admin'
  end

  def viewable_people
    if admin?
      Person.all
    else
      people
    end
  end

  def viewable_groups
    Group.all
  end

  def viewable_groups_excluding_joined
    viewable_groups - groups
  end

  def membership_for(group)
    self.person.group_memberships.where(group: group).first
  end

  def member_of?(group)
    !!membership_for(group)
  end

  def name_or_email
    if person.present? && person.full_name.present?
      person.full_name
    else
      email
    end
  end

  private
  def find_or_create_person
    self.person = Person.find_or_create_by(email_address: self.email)
  end
end
