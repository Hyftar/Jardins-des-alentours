class CreateCommunities < ActiveRecord::Migration[6.0]
  def change
    create_table :communities do |t|
      t.references :region, null: false, foreign_key: true
      t.references :produce, null: false, foreign_key: true
      t.integer :score, null: false, default: 0

      t.timestamps
    end
  end
end
