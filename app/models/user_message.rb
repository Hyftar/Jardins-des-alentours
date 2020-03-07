class UserMessage < ApplicationRecord
  belongs_to :source_user, class_name: "User"
  belongs_to :recipient_user, class_name: "User"
  validates :content, presence: true, length: { maximum: 10_000 }
  belongs_to :source_user, class_name: "User"
  belongs_to :recipient_user, class_name: "User"
end
