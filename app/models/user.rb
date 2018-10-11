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
    if admin?
      Group.all
    else
      groups
    end
  end

  private
  def find_or_create_person
    self.person = Person.find_or_create_by(email_address: self.email)
  end
end
