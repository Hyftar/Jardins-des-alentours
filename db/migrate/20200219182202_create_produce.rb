class CreateProduce < ActiveRecord::Migration[6.0]
  def change
    create_table :produce do |t|
      t.string :name, null: false
      t.text :description
      t.integer :score, null: false, default: 0

      t.timestamps
    end
  end
end
