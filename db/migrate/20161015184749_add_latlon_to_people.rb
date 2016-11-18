class AddLatlonToPeople < ActiveRecord::Migration[5.0]
  def change
    add_column :people, :lonlat, :st_point, geographic: true
  end
end
