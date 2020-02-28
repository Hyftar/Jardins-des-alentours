require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  test "should be able to save address" do
    a = Address.new(
      address_line_1: "36 Pinson Street",
      address_line_2: "Appartment 3",
      city: "Montreal",
      province: "Quebec",
      country: "Canada",
      postal_code: "H1E 5E4",
      location: locations(:montreal)
    )
    assert a.save
  end

  test "should not be able to save address without address_line_1" do
    a = Address.new(
      address_line_2: "Appartment 3",
      city: "Montreal",
      province: "Quebec",
      country: "Canada",
      location: locations(:montreal)
    )
    assert_not a.save
  end

  test "should not be able to save address without city" do
    a = Address.new(
      address_line_1: "36 Pinson Street",
      address_line_2: "Appartment 3",
      province: "Quebec",
      country: "Canada",
      location: locations(:montreal)
    )
    assert_not a.save
  end

  test "should not be able to save address without province" do
    a = Address.new(
      address_line_1: "36 Pinson Street",
      address_line_2: "Appartment 3",
      city: "Montreal",
      country: "Canada",
      location: locations(:montreal)
    )
    assert_not a.save
  end

  test "should not be able to save address without country" do
    a = Address.new(
      address_line_1: "36 Pinson Street",
      address_line_2: "Appartment 3",
      city: "Montreal",
      province: "Quebec",
      location: locations(:montreal)
    )
    assert_not a.save
  end

  test "should not be able to save address without location" do
    a = Address.new(
      address_line_1: "36 Pinson Street",
      address_line_2: "Appartment 3",
      city: "Montreal",
      province: "Quebec",
      country: "Canada"
    )
    assert_not a.save
  end

  test "should be able to save address without postal_code" do
    a = Address.new(
      address_line_1: "36 Pinson Street",
      address_line_2: "Appartment 3",
      city: "Montreal",
      province: "Quebec",
      country: "Canada",
      location: locations(:montreal)
    )
    assert a.save
  end

  test "should be able to save address without address_line_2" do
    a = Address.new(
      address_line_1: "36 Pinson Street",
      city: "Montreal",
      province: "Quebec",
      country: "Canada",
      location: locations(:montreal)
    )
    assert a.save
  end



end
