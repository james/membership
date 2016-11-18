class AddMailgunIdToMailouts < ActiveRecord::Migration[5.0]
  def change
    add_column :mailouts, :mailgun_id, :string
  end
end
