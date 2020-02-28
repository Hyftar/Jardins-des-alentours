class GardenVariety < ApplicationRecord
  belongs_to :garden
  belongs_to :variety
  has_many :markets
  validates :is_active, inclusion: { in: [true, false] }
end
