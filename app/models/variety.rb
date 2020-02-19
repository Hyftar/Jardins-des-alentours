class Variety < ApplicationRecord
  belongs_to :produce

  validates :name, presence: true, length: { minimum: 2, maximum: 120 }
  validates :produce, presence: true

  has_many :garden_varieties
  has_many :gardens, through: :garden_varieties
end
