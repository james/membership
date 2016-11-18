class AddDetailsToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :description, :text
    add_column :groups, :why_receiving, :string
    add_column :groups, :automatic_update, :boolean, default: true
  end
end
