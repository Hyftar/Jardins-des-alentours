class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :address_line_1, null: false
      t.string :address_line_2
      t.string :city, null: false
      t.string :province, null: false
      t.string :country, null: false
      t.string :postal_code
      t.references :location, null: false, foreign_key: true, index: { unique: true }

      t.timestamps
    end
  end
end
