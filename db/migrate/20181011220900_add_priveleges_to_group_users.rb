class AddPrivelegesToGroupUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :group_users, :can_manage_members, :boolean, default: true
    add_column :group_users, :is_public, :boolean, default: true
    add_column :group_users, :can_manage_group, :boolean, default: true
  end
end
