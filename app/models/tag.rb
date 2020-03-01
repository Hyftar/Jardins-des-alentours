class Tag < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  has_and_belongs_to_many :questions
end
