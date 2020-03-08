class AnswerVote < Vote
  belongs_to :answer
  after_create :update_scores_on_create
  after_destroy :update_score_on_destroy
  after_update :update_score_on_update

  validates_uniqueness_of :user_id, scope: :answer_id

  def update_score_on_update
    if self.previous_changes.key?(:vote)
      ApplicationHelper.update_score_of(
        [user, answer],
        vote_value * 2 # Counts double to undo the current vote
      )

      self.clear_changes_information
    end
  end

  def update_scores_on_create
    ApplicationHelper.update_score_of(
      [user, answer],
      vote_value
    )
  end

  def update_score_on_destroy
    ApplicationHelper.update_score_of(
      [user, answer],
      -vote_value # Negative value to undo the current vote
    )
  end
end
