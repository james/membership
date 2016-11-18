class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :email_address
      t.boolean :email_opt_in
      t.boolean :is_volunteer
      t.string :phone
      t.string :mobile
      t.boolean :mobile_opt_in
      t.string :employer
      t.string :occupation
      t.string :facebook_id
      t.string :twitter_login
      t.date :born_at

      t.timestamps
    end
  end
end
