class VisitorMessage < ApplicationRecord
  belongs_to :source_visitor_email, class_name: 'VisitorEmail'
  belongs_to :recipient_user, class_name: 'User'
  validates :content, presence: true, length: { maximum: 10_000 }
end
