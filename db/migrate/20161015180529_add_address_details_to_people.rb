class AddAddressDetailsToPeople < ActiveRecord::Migration[5.0]
  def change
    add_column :people, :address1, :string
    add_column :people, :address2, :string
    add_column :people, :city, :string
    add_column :people, :state, :string
    add_column :people, :country_code, :string
    add_column :people, :post_code, :string
    add_column :people, :lat, :decimal
    add_column :people, :lng, :decimal
  end
end
