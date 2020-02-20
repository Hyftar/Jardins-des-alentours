class VisitorEmail < ApplicationRecord
  belongs_to :visitor
  validates :email, email: true, presence: true, uniqueness: true
end
