class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :instagram_arts :longitude :longitude
    rename_column :instagram_arts :location_lat :latitude
  end
end
