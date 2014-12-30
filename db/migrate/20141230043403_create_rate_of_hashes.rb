class CreateRateOfHashes < ActiveRecord::Migration
  def change
    create_table :rate_of_hashes do |t|
      t.text :day_of

      t.timestamps
    end
  end
end
