require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test "should be able to report an email" do
    r = Report.new(
      reporter_email: "test123@example.com",
      reported_email: "test456@example.com",
      reason: "There is something wrong with this user.",
      status: 1,
      user: users(:one)
    )
    assert r.save
  end

  test "should be able to report an email using status string" do
    r = Report.new(
      reporter_email: "test123@example.com",
      reported_email: "test456@example.com",
      reason: "There is something wrong with this user.",
      status: "pending",
      user: users(:one)
    )
    assert r.save
  end

    test "should not be able to save report without valid status" do
    assert_raise do
      r = Report.new(
        reporter_email: "test123@example.com",
        reported_email: "test456@example.com",
        reason: "There is something wrong with this user.",
        status: "test",
        user: users(:one)
      )
    end
  end

  test "should not be able to report an email without reporter" do
    r = Report.new(
      reported_email: "test456@example.com",
      reason: "There is something wrong with this user.",
      status: 1,
      user: users(:one)
    )
    assert_not r.save
  end

  test "should not be able to report without a reported_email" do
    r = Report.new(
      reporter_email: "test123@example.com",
      reason: "There is something wrong with this user.",
      status: 1,
      user: users(:one)
    )
    assert_not r.save
  end

  test "should not be able to report an email without a reason" do
    r = Report.new(
      reporter_email: "test123@example.com",
      reported_email: "test456@example.com",
      status: 1,
      user: users(:one)
    )
    assert_not r.save
  end

  test "should be able to report an email without a status" do
    r = Report.new(
      reporter_email: "test123@example.com",
      reported_email: "test456@example.com",
      reason: "There is something wrong with this user.",
      user: users(:one)
    )
    assert r.save
  end

  test "should not be able to report an unvalid email" do
    r = Report.new(
      reporter_email: "test123@examp@le.com",
      reported_email: "test456@example.com",
      reason: "There is something wrong with this user.",
      status: 1,
      user: users(:one)
    )
    assert_not r.save
  end

  test "should be able to report email without an user" do
    r = Report.new(
      reporter_email: "test123@example.com",
      reported_email: "test456@example.com",
      reason: "There is something wrong with this user.",
      status: 1
    )
    assert r.save
  end

end
