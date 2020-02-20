class CreateGardenVarieties < ActiveRecord::Migration[6.0]
  def change
    create_table :garden_varieties do |t|
      t.references :garden, null: false, foreign_key: true
      t.references :variety, null: false, foreign_key: true
      t.boolean :is_active, null: false, default: 1

      t.timestamps
    end
  end
end
