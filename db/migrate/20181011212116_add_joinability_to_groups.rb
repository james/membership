class AddJoinabilityToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :joinable, :boolean, default: true
    add_column :groups, :leavable, :boolean, default: true
  end
end
