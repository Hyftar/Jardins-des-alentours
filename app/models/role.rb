class Role < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }, uniqueness: true
  validates :description, length: { maximum: 10_000 }
  has_and_belongs_to_many :users
end
