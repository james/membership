class AddPersonToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :person, foreign_key: true
  end
end
