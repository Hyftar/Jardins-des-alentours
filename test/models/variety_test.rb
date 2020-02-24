require "test_helper"

class VarietyTest < ActiveSupport::TestCase
  test "should not be able to add variety without name" do
    v = Variety.new
    v.description = "Test12345"
    v.produce = produce(:potatoes)
    assert_not v.save
  end

  test "should not be able to save variety without produce" do
    v = Variety.new(
      name: "Blah",
      description: "Bleh"
    )

    assert_not v.save
  end

  test "should be able to add new variety" do
    v = Variety.new(
      name: "Homegrown tomatoes",
      produce: produce(:tomatoes),
      description: "Tomatoes that are homegrown"
    )
    assert v.save
  end

  test "should allow variety without description" do
    v = Variety.new(
      name: "Test12345",
      produce: produce(:potatoes)
    )
    assert v.save
  end
end
