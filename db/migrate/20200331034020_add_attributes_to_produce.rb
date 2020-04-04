class AddAttributesToProduce < ActiveRecord::Migration[6.0]
  def change
    drop_table :produce, force: :cascade
    add_column :varieties, :latin_name, :string, null: true
    add_column :varieties, :spacing, :float, null: true
    add_column :varieties, :height, :float, null: true
    add_column :varieties, :family, :string, null: true
    add_column :varieties, :hardiness_zone, :integer, null: true
    add_column :varieties, :germination_time, :integer, null: true
    add_column :varieties, :culture_start, :date, null: true
    add_column :varieties, :freeze_resistance, :boolean, null: true
    add_column :varieties, :culture_end, :date, null: true
    add_column :varieties, :sun_exposure, :integer, null: true
    add_column :varieties, :planting_method, :integer, null: false, default: 0
    add_reference :varieties, :origin, null: true, index: true, foreign_key: { to_table: :locations }
    add_reference :varieties, :parent, null: true, index: true, foreign_key: { to_table: :varieties }
    add_reference :communities, :variety, null: false, index: true, foreign_key: true
    remove_column :communities, :produce_id
  end
end
