class CreateGeodata < ActiveRecord::Migration
  def change
    create_table :geodata do |t|
      t.string :purpose
      t.text :content

      t.timestamps
    end
  end
end
