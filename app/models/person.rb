class Person < ApplicationRecord
  has_many :group_memberships, dependent: :destroy
  has_many :groups, through: :group_memberships

  filterrific(
    available_filters: [
      :in_group,
      :by_name,
      :by_membership_status,
      :born_before,
      :born_after,
      :within_bounds
    ]
  )

  scope :in_group, ->(group_id) { includes(:groups).where("groups.id": group_id) }
  scope :by_name, ->(name) { where(first_name: name) }
  scope :born_before, ->(date) { where("born_at < ?", date) }
  scope :born_after, ->(date) { where("born_at > ?", date) }
  scope :by_membership_status, ->(membership_status) {
    if membership_status == 'member'
      where("membership_id IS NOT NULL")
    elsif membership_status == 'notmember'
      where("membership_id IS NULL")
    end
  }
  scope :within_bounds, ->(bounds) {
    poly = RGeo::GeoJSON.decode(bounds, json_parser: :json).first
    if poly
      where("ST_Intersects(ST_GeomFromText(?), lonlat)", poly.geometry.as_text)
    end
  }

  def full_name
    "#{first_name} #{last_name}"
  end
end
