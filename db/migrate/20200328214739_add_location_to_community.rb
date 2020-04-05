class AddLocationToCommunity < ActiveRecord::Migration[6.0]
  def change
    remove_column :communities, :region_id
    drop_table :regions, force: :cascade
    add_reference :communities, :location, null: false, foreign_key: true
  end
end
