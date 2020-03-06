class DropAddresses < ActiveRecord::Migration[6.0]
  def change
    drop_table :addresses
    add_column :locations, :house_number, :string
    add_column :locations, :road, :string
    add_column :locations, :neighbourhood, :string
    add_column :locations, :suburb, :string
    add_column :locations, :county, :string
    add_column :locations, :additional_informations, :string
    add_column :locations, :city, :string
    add_column :locations, :province, :string
    add_column :locations, :region, :string
    add_column :locations, :country, :string
    add_column :locations, :country_code, :string
    add_column :locations, :postal_code, :string
    change_column_null :locations, :latitude, true
    change_column_null :locations, :longitude, true
  end
end
