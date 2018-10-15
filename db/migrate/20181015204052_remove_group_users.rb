class RemoveGroupUsers < ActiveRecord::Migration[5.0]
  def change
    drop_table :group_users
  end
end
