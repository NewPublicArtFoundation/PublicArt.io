class AddAddressToInstagramArt < ActiveRecord::Migration
  def change
    add_column :instagram_arts, :address, :string
  end
end
