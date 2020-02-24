require "test_helper"

class ProduceTest < ActiveSupport::TestCase
  test "should not be able to save a produce without category" do
    p = Produce.new(
      name: "Tomata"
    )

    assert_not p.save
  end

  test "should not be able to save a produce without a name" do
    p = Produce.new(
      description: "Test",
      categories: [categories(:one)]
    )

    assert_not p.save
  end

  test "should be able to save a produce" do
    p = Produce.new(
      name: "Tomata",
      categories: [categories(:one)]
    )

    assert p.save
  end
end
