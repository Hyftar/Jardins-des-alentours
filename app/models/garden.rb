class Garden < ApplicationRecord
  validates :name, presence: true, length: { minimum: 1, maximum: 120 }
  validates :description, length: { maximum: 10_000 }

  belongs_to :user

  has_many :garden_varieties
  has_many :varieties, through: :garden_varieties
end
