require "test_helper"

class CommunityTest < ActiveSupport::TestCase
  test "should not be able to save without location" do
    c = Community.new(
      variety: varieties(:one)
    )

    assert_not c.save
  end

  test "should not be able to save without variety" do
    c = Community.new(
      location: locations(:montreal)
    )

    assert_not c.save
  end

  test "should automatically create roles after its creation" do
    c = Community.create(
      variety: varieties(:one),
      location: locations(:montreal)
    )

    roles = Role.where(community: c)

    assert_equal 2, roles.size, "Two roles should be created for the community"
    assert_equal %w( moderator admin ), roles.map(&:name), "Roles should be named moderator and admin"
  end
end
