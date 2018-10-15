class AddRoleholderInfoToGroupMemberships < ActiveRecord::Migration[5.0]
  def change
    add_column :group_memberships, :roleholder, :boolean, default: false
    add_column :group_memberships, :role_name, :string
    add_column :group_memberships, :can_manage_members, :boolean, default: false
    add_column :group_memberships, :is_public, :boolean, default: false
    add_column :group_memberships, :can_manage_group, :boolean, default: false
  end
end
