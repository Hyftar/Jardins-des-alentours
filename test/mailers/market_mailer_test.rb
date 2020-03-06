require 'test_helper'

class MarketMailerTest < ActionMailer::TestCase
  test "update market notification email" do
    market = market(:one)
    notifications = [market_notification(:one),market_notification(:two)]
    email = MarketMailer.with(market: market, market_notification: notifications).market_disponibility_update_email

    assert_emails 2 do
      email.deliver_now
    end
  end
end
