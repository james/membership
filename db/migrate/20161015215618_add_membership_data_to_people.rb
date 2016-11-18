class AddMembershipDataToPeople < ActiveRecord::Migration[5.0]
  def change
    add_column :people, :membership_id, :integer
    add_column :people, :membership_started_at, :datetime
    add_column :people, :membership_level, :string
    add_column :people, :paypal_id, :string
  end
end
