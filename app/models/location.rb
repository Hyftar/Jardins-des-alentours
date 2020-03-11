class Location < ApplicationRecord
  validates :longitude,
    numericality: {
      greater_than_or_equal_to: -180,
      less_than_or_equal_to: 180
    },
    allow_nil: true

  validates :latitude,
    numericality: {
      greater_than_or_equal_to: -90,
      less_than_or_equal_to: 90
    },
    allow_nil: true

  geocoded_by :address_join do |obj, results|
    # sleep to reduce number of calls to api to 1 per second
    sleep(1)
    byebug
    if geo = results.first
      obj.latitude = geo.latitude
      obj.longitude = geo.longitude
      obj.house_number = geo.house_number
      obj.road = geo.street
      obj.neighbourhood = geo.data["address"]["neighbourhood"]
      obj.suburb = geo.data["address"]["suburb"]
      obj.region = geo.data["address"]["region"]
      obj.county = geo.data["address"]["county"]
      obj.city = geo.city
      obj.province = geo.state
      obj.country = geo.country
      obj.country_code = geo.country_code
      obj.postal_code = geo.postal_code
    end
  end

  def address_join
    @test = [house_number, road, city, province, country].compact.join(", ")
  end

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    # sleep to reduce number of calls to api to 1 per second
    sleep(1)
    if geo = results.first
      obj.house_number = geo.house_number
      obj.road = geo.street
      obj.neighbourhood = geo.data["address"]["neighbourhood"]
      obj.suburb = geo.data["address"]["suburb"]
      obj.region = geo.data["address"]["region"]
      obj.county = geo.data["address"]["county"]
      obj.city = geo.city
      obj.province = geo.state
      obj.country = geo.country
      obj.country_code = geo.country_code
      obj.postal_code = geo.postal_code
    end
  end

  after_validation :reverse_geocode, if: ->(obj) {
    (obj.latitude.present? && obj.latitude_changed?)||
    (obj.longitude.present? && obj.longitude_changed?)
  }

  after_validation :geocode, if: ->(obj) {
    (obj.house_number.present? && obj.house_number_changed?)||
    (obj.road.present? && obj.road_changed?)||
    (obj.neighbourhood.present? && obj.neighbourhood_changed?)||
    (obj.suburb.present? && obj.suburb_changed?)||
    (obj.region.present? && obj.region_changed?)||
    (obj.county.county? && obj.county_changed?)||
    (obj.city.present? && obj.city_changed?)||
    (obj.province.present? && obj.province_changed?)||
    (obj.country.present? && obj.country_changed?)||
    (obj.country_code.present? && obj.country_code_changed?)||
    (obj.postal_code.present? && obj.postal_code_changed?)
  }
end
