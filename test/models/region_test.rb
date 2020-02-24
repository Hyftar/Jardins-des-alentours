require "test_helper"

class RegionTest < ActiveSupport::TestCase
  test "should not be able to save region without name" do
    r = Region.new(location: locations(:montreal))
    assert_not r.save
  end

  test "should not be able to save region without location" do
    r = Region.new(name: "Rive sud")
    assert_not r.save
  end

  test "should be able to save region" do
    r = Region.new(
      name: "Rive sud",
      location: locations(:montreal)
    )
    assert r.save
  end

  test "should be able to save region with description" do
    r = Region.new(
      name: "Rive sud",
      location: locations(:montreal),
      description: "La rive sud de Montréal"
    )
    assert r.save
  end
end
