require "test_helper"

class MarketNotificationTest < ActiveSupport::TestCase
  test "should be able to save market notification" do
    m = MarketNotification.new(
      email: "jacqueline@example.com",
      market: markets(:two),
      status: 0
    )
    assert m.save
  end

  test "should be able to save market notification with status string" do
    m = MarketNotification.new(
      email: "jacqueline@example.com",
      market: markets(:two),
      status: "active"
    )
    assert m.save
  end

  test "should not be able to save market notification without valid email" do
    m = MarketNotification.new(
      email: "deih@fhcek@google.ca",
      market: markets(:one),
      status: 1
    )
    assert_not m.save
  end

  test "should not be able to save market notification without valid status" do
    assert_raise do
      m = MarketNotification.new(
        email: "deih@fhcek@google.ca",
        market: markets(:one),
        status: "test"
      )
    end
  end

  test "should not be able to save market notification without email" do
    m = MarketNotification.new(
      market: markets(:one),
      status: 2
    )
    assert_not m.save
  end

  test "should not be able to save market notification without status" do
    m = MarketNotification.new(
      email: "deih@fhcek@google.ca",
      market: markets(:one)
    )
    assert_not m.save
  end

  test "should not be able to save market notification without market" do
    m = MarketNotification.new(
      email: "deih@fhcek@google.ca",
      status: 2
    )
    assert_not m.save
  end
end
