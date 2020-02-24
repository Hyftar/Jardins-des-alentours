require "test_helper"

class GardenTest < ActiveSupport::TestCase
  test "should not be able to save garden without name" do
    g = Garden.new(
      user: users(:one),
      description: "My common tomatoes garden",
      varieties: [varieties(:two)]
    )

    assert_not g.save
  end


  test "should not be able to save garden without user" do
    g = Garden.new(
      name: "test1234",
      description: "My common tomatoes garden",
      varieties: [varieties(:two)]
    )

    assert_not g.save
  end

  test "should be able to save garden with varieties" do
    g = Garden.new(
      user: users(:one),
      name: "test1234",
      description: "My common tomatoes garden",
      varieties: [varieties(:two)]
    )

    assert_equal "Unspecified Tomatoes", g.varieties.first.name
    assert_equal true, g.garden_varieties.first.is_active
    assert g.save
  end

  test "should be able to save garden without varieties" do
    g = Garden.new(
      user: users(:one),
      name: "test1234",
      description: "My common tomatoes garden"
    )

    assert g.save
  end
end
