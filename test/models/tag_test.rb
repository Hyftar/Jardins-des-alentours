require "test_helper"

class TagTest < ActiveSupport::TestCase
  test "should not be able to save Tag without name" do
    tag = Tag.new
    assert_not tag.save
  end

  test "should not be able to save tag with name shorter than 2 characters" do
    tag = Tag.create(
      name: "a"
    )
    assert_not tag.save
  end

  test "should not be able to save tag with name longer than 50 characters" do
    tag = Tag.create(
      name: "dsyhjgdsfghashjkfgsafhjksgfkjasgfkjaksjfhsakjfhsjsiodgsg"
    )
    assert_not tag.save
  end

  test "should be able to save valid tag" do
    tag = Tag.create(
      name: "test_Tag_123"
    )
    assert tag.save
  end
end
