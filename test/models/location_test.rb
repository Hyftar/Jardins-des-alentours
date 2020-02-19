require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  test "-181 should not be valid longitude" do
    l = Location.new(
      longitude: -181,
      latitude: 45
    )

    assert_not l.save
  end

  test "181 should not be valid longitude" do
    l = Location.new(
      longitude: 181,
      latitude: 45
    )

    assert_not l.save
  end

  test "-100 should not be valid latitude" do
    l = Location.new(
      longitude: 70,
      latitude: -100
    )

    assert_not l.save
  end

  test "100 should not be valid latitude" do
    l = Location.new(
      longitude: 70,
      latitude: 100
    )

    assert_not l.save
  end

  test "should be valid location" do
    l = Location.new(
      longitude: 70.05,
      latitude: -43.23
    )

    assert l.save
  end
end
