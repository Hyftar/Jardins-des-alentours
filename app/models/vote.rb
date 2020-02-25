class Vote < ApplicationRecord
  self.abstract_class = true
  belongs_to :user
  enum vote: { down: -1, up: 1 }

  def vote_value
    Vote.votes[self.vote]
  end
end
