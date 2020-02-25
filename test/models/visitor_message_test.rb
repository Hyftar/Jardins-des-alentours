require "test_helper"

class VisitorMessageTest < ActiveSupport::TestCase
  test "should save visitor_message" do
    m = VisitorMessage.new(
      source_visitor_email: visitor_emails(:one),
      recipient_user: users(:two),
      content: "I want to buy two salads."
    )
    assert m.save
  end

  test "should not save visitor_message without content" do
    m = VisitorMessage.new(
      source_visitor_email: visitor_emails(:one),
      recipient_user: users(:two),
    )
    assert_not m.save
  end

  test "should not save visitor_message without a source" do
    m = VisitorMessage.new(
      recipient_user: users(:two),
      content: "I want to buy two salads."
    )
    assert_not m.save
  end

  test "should not save visitor_message without a recipient" do
    m = VisitorMessage.new(
      source_visitor_email: visitor_emails(:one),
      content: "I want to buy two salads."
    )
    assert_not m.save
  end
end
