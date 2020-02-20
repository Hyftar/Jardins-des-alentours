class CreateMarkets < ActiveRecord::Migration[6.0]
  def change
    create_table :markets do |t|
      t.references :garden_variety, null: false, foreign_key: true
      t.integer :quantity, default: 0
      t.string :unit, null: false

      t.timestamps
    end
  end
end
