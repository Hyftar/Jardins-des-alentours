class CreateVarieties < ActiveRecord::Migration[6.0]
  def change
    create_table :varieties do |t|
      t.string :name, null: false
      t.text :description
      t.references :produce, null: false, foreign_key: true
      t.integer :score, null: false, default: 0

      t.timestamps
    end
  end
end
