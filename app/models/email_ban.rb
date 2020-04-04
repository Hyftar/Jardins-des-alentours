class EmailBan < ApplicationRecord
  validates :email, presence: true, email: true
  validates :banned_until, presence: true
  validates :reason, length: { maximum: 10_000 }
  belongs_to :user
end
