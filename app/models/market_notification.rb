class MarketNotification < ApplicationRecord
  validates :email, email: true, presence: true
  validates :status, presence: true
  enum status: { active: 0, paused: 1, deleted: 2 }
  belongs_to :market
end
