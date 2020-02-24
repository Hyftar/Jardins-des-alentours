require "test_helper"

class VisitorLocationTest < ActiveSupport::TestCase
  test "-181 should not be valid longitude" do
    l = VisitorLocation.new(
      longitude: -181,
      latitude: 45,
      visitor: visitors(:one)
    )

    assert_not l.save
  end

  test "181 should not be valid longitude" do
    l = VisitorLocation.new(
      longitude: 181,
      latitude: 45,
      visitor: visitors(:one)
    )

    assert_not l.save
  end

  test "-100 should not be valid latitude" do
    l = VisitorLocation.new(
      longitude: 70,
      latitude: -100,
      visitor: visitors(:one)
    )

    assert_not l.save
  end

  test "100 should not be valid latitude" do
    l = VisitorLocation.new(
      longitude: 70,
      latitude: 100,
      visitor: visitors(:one)
    )

    assert_not l.save
  end

  test "should be valid visitor location" do
    l = VisitorLocation.new(
      longitude: 70.05,
      latitude: -43.23,
      visitor: visitors(:one)
    )

    assert l.save
  end


  test "should not be valid visitor location without visitor" do
    l = VisitorLocation.new(
      longitude: 70.05,
      latitude: -43.23,
    )

    assert_not l.save
  end
end
