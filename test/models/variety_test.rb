require "test_helper"

class VarietyTest < ActiveSupport::TestCase

  test "should be able to save variety" do
    v = Variety.new(
      name: "Cucumbers",
      description: "Cucumbers are green elongated vegetables",
      latin_name: "Cucumis sativus",
      spacing: 1,
      height: 50,
      family: "Gourds",
      hardiness_zone: 3,
      germination_time: 5,
      culture_start: "2000-06-11",
      freeze_resistance: 0,
      culture_end: "2000-09-11",
      sun_exposure: 0,
      planting_method: 3,
      origin: locations(:montreal)
    )
    assert v.save
  end

  test "should be able to save variety child of other variety" do
    v = Variety.new(
      name: "Cherry tomatoes",
      description: "Small round tomatoes",
      spacing: 1,
      height: 50,
      hardiness_zone: 3,
      germination_time: 5,
      culture_start: "2000-06-11",
      freeze_resistance: 0,
      culture_end: "2000-09-11",
      sun_exposure: 0,
      planting_method: 3,
      origin: locations(:montreal),
      parent: varieties(:one)
    )
    assert v.save
  end

  test "should not be able to save variety without name" do
    v = Variety.new(
      description: "Small round tomatoes",
      spacing: 1,
      height: 50,
      hardiness_zone: 3,
      germination_time: 5,
      culture_start: "2000-06-11",
      freeze_resistance: 0,
      culture_end: "2000-09-11",
      sun_exposure: 0,
      planting_method: 3,
      origin: locations(:montreal),
      parent: varieties(:one)
    )
    assert_not v.save
  end

  test "parent should not be self" do
    v = Variety.new(
      name: "Cucumbers",
      description: "Cucumbers are green elongated vegetables",
      latin_name: "Cucumis sativus",
      spacing: 1,
      height: 50,
      family: "Gourds",
      hardiness_zone: 3,
      germination_time: 5,
      culture_start: "2000-06-11",
      freeze_resistance: 0,
      culture_end: "2000-09-11",
      sun_exposure: 0,
      planting_method: 3,
    )
    assert v.save

    v.parent = v
    assert_not v.save
  end

end
