class Report < ApplicationRecord
  belongs_to :user, optional: true
  validates :reporter_email, presence: true, email: true
  validates :reported_email, presence: true, email: true
  validates :reason, presence: true, length: { maximum: 10_000 }
  validates :status, presence: true
  enum status: %i( pending accepted rejected investigating )
end
