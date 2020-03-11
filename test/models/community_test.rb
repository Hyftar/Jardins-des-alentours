require "test_helper"

class CommunityTest < ActiveSupport::TestCase
  test "should not be able to save without region" do
    c = Community.new(
      produce: produce(:tomatoes)
    )

    assert_not c.save
  end

  test "should not be able to save without produce" do
    c = Community.new(
      region: regions(:one)
    )

    assert_not c.save
  end

  test "should automatically create roles after its creation" do
    c = Community.create(
      produce: produce(:tomatoes),
      region: regions(:one)
    )

    roles = Role.where(community: c)

    assert_equal 2, roles.size, "Two roles should be created for the community"
    assert_equal %w( moderator admin ), roles.map(&:name), "Roles should be named moderator and admin"
  end
end
