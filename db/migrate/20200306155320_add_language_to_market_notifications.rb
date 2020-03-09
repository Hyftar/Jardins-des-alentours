class AddLanguageToMarketNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :market_notifications, :language, :string
  end
end
