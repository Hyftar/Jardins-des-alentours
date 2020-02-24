require "test_helper"

class MarketTest < ActiveSupport::TestCase
  test "should be able to save market" do
    m = Market.new(
      garden_variety: garden_varieties(:one),
      quantity: 24,
      unit: "units"
    )

    assert m.save
  end

  test "should not be able to save market without gardien variety" do
    m = Market.new(
      quantity: 36,
      unit: "grams"
    )

    assert_not m.save
  end

  test "should not be able to save market with negative quantity" do
    m = Market.new(
      garden_variety: garden_varieties(:one),
      quantity: -24,
      unit: "units"
    )

    assert_not m.save
  end

  test "should not be able to save market without units" do
    m = Market.new(
      garden_variety: garden_varieties(:one),
      quantity: 24,
    )

    assert_not m.save
  end

  test "should be able to save market without quantity" do
    m = Market.new(
      garden_variety: garden_varieties(:one),
      unit: "units"
    )

    assert m.save
  end
end
