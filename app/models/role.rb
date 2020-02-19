class Role < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }, uniqueness: true
  has_and_belongs_to_many :users
end
