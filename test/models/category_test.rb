require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "should not be able to save category without name" do
    c = Category.new(
      description: "Fresh tomates"
    )
    assert_not c.save
  end

  test "should be able to save a category" do
    c = Category.new(
      name: "abcdef",
    )

    assert c.save
  end
end
