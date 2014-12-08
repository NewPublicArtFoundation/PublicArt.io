class CreateAccesskeys < ActiveRecord::Migration
  def change
    create_table :accesskeys do |t|
      t.string :client_id
      t.string :client_secret
      t.string :callback_url
      t.string :source_url

      t.timestamps
    end
  end
end
