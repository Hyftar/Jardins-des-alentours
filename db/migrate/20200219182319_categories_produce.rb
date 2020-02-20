class CategoriesProduce < ActiveRecord::Migration[6.0]
  def change
    create_table :categories_produce do |t|
      t.references :produce, foreign_key: true, null: false
      t.references :category, foreign_key: true, null: false
    end
  end
end
