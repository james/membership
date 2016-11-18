class User < ApplicationRecord
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :group_memberships, through: :groups
  has_many :people, through: :group_memberships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

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
end
