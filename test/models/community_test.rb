require 'test_helper'

class CommunityTest < ActiveSupport::TestCase
  test "should not be able to save without region" do
    c = Community.new(
      produce: produce(:tomatoes)
    )

    assert_not c.save
  end

  test "should not be able to save without produce" do
    c = Community.new(
      region: regions(:one)
    )

    assert_not c.save
  end
end
