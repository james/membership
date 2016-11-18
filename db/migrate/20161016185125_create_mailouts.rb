class CreateMailouts < ActiveRecord::Migration[5.0]
  def change
    create_table :mailouts do |t|
      t.references :group, foreign_key: true
      t.string :subject
      t.text :body
      t.references :user, foreign_key: true
      t.string :from_email
      t.string :from_first_name
      t.string :from_last_name

      t.timestamps
    end
  end
end
