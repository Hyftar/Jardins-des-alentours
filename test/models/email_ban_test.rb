require "test_helper"

class EmailBanTest < ActiveSupport::TestCase
  test "should be able to save email ban" do
    b = EmailBan.new(
      email: "labernois123@test.ca",
      banned_until: 1.day.from_now,
      user: users(:one),
      reason: "This user is baaaaaaaaaad."
    )

    assert b.save
  end

  test "should be able to save email ban without reason" do
    b = EmailBan.new(
      email: "labernois123@test.ca",
      banned_until: 1.day.from_now,
      user: users(:one)
    )

    assert b.save
  end

  test "should not be able to save email ban without valid email" do
    b = EmailBan.new(
      email: "labernois123@test@.ca",
      banned_until: 1.day.from_now,
      user: users(:one)
    )

    assert_not b.save
  end

  test "should not be able to save email ban without future banned_date" do
    b = EmailBan.new(
      email: "labernois123@test.ca",
      banned_until: 1.day.ago,
      user: users(:one)
    )
    assert_not b.save
  end

  test "should not be able to save email ban without email" do
    b = EmailBan.new(
      banned_until: 1.day.ago,
      user: users(:one)
    )
    assert_not b.save
  end

  test "should not be able to save email ban without user" do
    b = EmailBan.new(
      banned_until: 1.day.ago,
      email: "labernois123@test.ca"
    )
    assert_not b.save
  end

  test "should not be able to save email ban without banned_date" do
    b = EmailBan.new(
      email: "labernois123@test.ca",
      user: users(:one)
    )
    assert_not b.save
  end
end
