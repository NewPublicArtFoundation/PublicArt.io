class AddFlaggeddToInstagramarts < ActiveRecord::Migration
  def change
    add_column :instagram_arts, :boolean, :default => nil
  end
end
