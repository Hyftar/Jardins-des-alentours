class Address < ApplicationRecord
  belongs_to :location
  validates :address_line_1, presence: true, length: { minimum: 1, maximum: 120 }
  validates :address_line_2, length: { maximum: 120 }
  validates :city, presence: true, length: { minimum: 1, maximum: 120 }
  validates :province, presence: true, length: { minimum: 1, maximum: 120 }
  validates :country, presence: true, length: { minimum: 1, maximum: 120 }
  validates :postal_code, length: { maximum: 20 }
end
