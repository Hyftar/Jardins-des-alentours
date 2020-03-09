class ChangeMarketNotificationDefault < ActiveRecord::Migration[6.0]
  def change
    change_column :market_notifications, :status, :integer, default: 0
  end
end
