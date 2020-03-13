class Market < ApplicationRecord
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0, less_than: 1000 }, allow_nil: true
  validates :unit, presence: true
  belongs_to :garden_variety
  has_many :market_notifications
  validates :is_active, inclusion: { in: [true, false] }
end
