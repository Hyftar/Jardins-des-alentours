class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_one :community, through: :question

  # Active is the default status
  # Removed means it has been deleted by an admin
  # Deleted means it has been deleted by the user
  enum status: %i( active removed deleted )
end
