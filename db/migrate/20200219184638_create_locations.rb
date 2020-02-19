class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.float :longitude, null: false
      t.float :latitude, null: false
    end
  end
end
