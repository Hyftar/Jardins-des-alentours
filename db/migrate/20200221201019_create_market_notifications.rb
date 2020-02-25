class CreateMarketNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :market_notifications do |t|
      t.string :email, null: false
      t.references :market, foreign_key: true
      t.integer :status, null: false

      t.timestamps
    end
  end
end
