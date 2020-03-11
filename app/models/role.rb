class Role < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, length: { maximum: 10_000 }

  validates_uniqueness_of :name, scope: :community_id

  has_and_belongs_to_many :users
  belongs_to :community, optional: true
end
