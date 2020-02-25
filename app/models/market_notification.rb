class MarketNotification < ApplicationRecord
  validates :email, email: true, presence: true
  validates :status, presence: true
  enum status: %i( active paused deleted )
  belongs_to :market
end
