require 'test_helper'

class VisitorTest < ActiveSupport::TestCase
  test "should be able to save visitor" do
    v = Visitor.new(
      IP: '192.168.3.102',
      request_count: 1
    )

    assert v.save
  end

  test "should be able to save visitor without request_count" do
    v = Visitor.new(
      IP: '192.168.3.102',
    )

    assert v.save
  end

  test "should not be able to save visitor without IP address" do
    v = Visitor.new(
    )

    assert_not v.save
  end

  test "should not be able to save visitor with non-valid IP address" do
    v = Visitor.new(
      IP: '256.300.3.102',
      request_count: 1
    )

    assert_not v.save
  end

  test "should not be able to save visitor with negative request_count" do
    v = Visitor.new(
      IP: '244.234.1.2',
      request_count: -1
    )

    assert_not v.save
  end
end
