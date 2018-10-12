class RenamePeopleToMembers < ActiveRecord::Migration[5.0]
  def change
    rename_table :people, :members
    rename_column :group_memberships, :person_id, :member_id
    rename_column :users, :person_id, :member_id
  end
end
