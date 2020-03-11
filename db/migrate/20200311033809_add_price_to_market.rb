class AddPriceToMarket < ActiveRecord::Migration[6.0]
  def change
    add_column :markets, :price, :decimal, precision: 5, scale: 2
  end
end
