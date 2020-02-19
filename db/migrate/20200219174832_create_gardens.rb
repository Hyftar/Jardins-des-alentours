class CreateGardens < ActiveRecord::Migration[6.0]
  def change
    create_table :gardens do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :score, null: false, default: 0
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
  end
end
