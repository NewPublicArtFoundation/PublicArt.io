class AddFlaggeddToInstagramarts < ActiveRecord::Migration
  def change
    add_column :instagram_arts, :flagged, :boolean, :default => nil
  end
end
