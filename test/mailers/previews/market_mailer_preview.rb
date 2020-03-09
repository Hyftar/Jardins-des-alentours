# Preview all emails at http://localhost:3000/rails/mailers/market_mailer
class MarketMailerPreview < ActionMailer::Preview
  def market_disponibility_update_email
    @market_notifications = [MarketNotification.new(email: "test@example.com", market: Market.first, status: 0), MarketNotification.new(email: "test2@example.com", market: Market.first, status: 0)]
    MarketMailer.with(market: Market.first, market_notifications: @market_notifications).market_disponibility_update_email
  end
end
