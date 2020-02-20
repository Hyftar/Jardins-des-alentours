class Region < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2, maximum: 200 }
  validates :description, length: { maximum: 10_000 }
  belongs_to :location
  has_many :communities
end
