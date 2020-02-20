class CreateVisitors < ActiveRecord::Migration[6.0]
  def change
    create_table :visitors do |t|
      t.inet :IP, null: false
      t.integer :request_count, default: 0

      t.timestamps
    end
  end
end
