require 'test_helper'

class UserMessageTest < ActiveSupport::TestCase
  test "should save user_message" do
    m = UserMessage.new(
      source_user: users(:one),
      recipient_user: users(:two),
      content: "I want to buy two salads."
    )
    assert m.save
  end

  test "should not save user_message without content" do
    m = UserMessage.new(
      source_user: users(:one),
      recipient_user: users(:two),
    )
    assert_not m.save
  end

  test "should not save user_message without a source" do
    m = UserMessage.new(
      recipient_user: users(:two),
      content: "I want to buy two salads."
    )
    assert_not m.save
  end

  test "should not save user_message without a recipient" do
    m = UserMessage.new(
      source_user: users(:one),
      content: "I want to buy two salads."
    )
    assert_not m.save
  end
end
