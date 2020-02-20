class CreateVisitorLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :visitor_locations do |t|
      t.float :longitude, null: false
      t.float :latitude, null: false
      t.references :visitor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
