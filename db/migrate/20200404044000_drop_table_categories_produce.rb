class DropTableCategoriesProduce < ActiveRecord::Migration[6.0]
  def change
    drop_table :categories_produce
    create_table :categories_varieties do |t|
      t.references :variety, foreign_key: true, null: false
      t.references :category, foreign_key: true, null: false
    end
  end
end
