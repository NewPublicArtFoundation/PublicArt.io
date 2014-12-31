class AddUidToInstagramArts < ActiveRecord::Migration
  def change
    add_column :instagram_arts, :uid, :string
    add_index :instagram_arts, :uid, :unique => true
  end
end
