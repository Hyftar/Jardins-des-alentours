class Report < ApplicationRecord
  belongs_to :user
  validates :reporter_email, presence: true, email: true
  validates :reported_email, presence: true, email: true
  validates :reason, presence: true, length: { maximum: 10_000 }
  validates :status, presence: true
  enum status: { pending: 0, accepted: 1, rejected: 2, investigating: 3 }
end
