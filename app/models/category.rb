class Category < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :description, length: { maximum: 10_000 }

  has_and_belongs_to_many :varieties
end
