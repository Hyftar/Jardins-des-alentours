class Location < ApplicationRecord
  validates :longitude,
    presence: true,
    numericality: {
      greater_than_or_equal_to: -180,
      less_than_or_equal_to: 180
    }

  validates :latitude,
    presence: true,
    numericality: {
      greater_than_or_equal_to: -90,
      less_than_or_equal_to: 90
    }
end
