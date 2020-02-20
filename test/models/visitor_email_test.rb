require 'test_helper'

class VisitorEmailTest < ActiveSupport::TestCase
  test "should be able to save visitor email" do
    e = VisitorEmail.new(
      email: "lelabernois123@gmail.com",
      visitor: visitors(:one)
    )
    assert e.save

  end

  test "should not be able to save visitor email with duplicate address" do
    e = VisitorEmail.new(
      email: "lelabernoiscircuits@gmail.com",
      visitor: visitors(:one)
    )

    assert_not e.save
  end

  test "should not be able to save visitor email without email" do
    e = VisitorEmail.new(
      visitor: visitors(:one)
    )
    
    assert_not e.save
  end

  test "should not be able to save visitor email without valid email" do
    e = VisitorEmail.new(
      email: "lelabernoisc@ircuits@gmail.com",
      visitor: visitors(:one)
    )
    
    assert_not e.save
  end

end
