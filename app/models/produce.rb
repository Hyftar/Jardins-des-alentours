class Produce < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :communities

  validates :name, length: { minimum: 2, maximum: 100 }, uniqueness: true
  validates :description, length: { maximum: 10_000 }
  validates :categories, presence: true
end
