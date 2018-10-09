class Organisation < ApplicationRecord
  after_create :create_tenent

  validates :name, presence: true
  validates :subdomain, presence: true,
                        uniqueness: { case_sensitive: false},
                        format: { with: /\A[\w\-]+\Z/i, message: 'contains invalid characters' }

  private
  def create_tenent
    Apartment::Tenant.create(subdomain)
  end
end
