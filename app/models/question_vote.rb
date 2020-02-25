class QuestionVote < Vote
  belongs_to :question
  after_create :update_scores_on_create
  after_destroy :update_score_on_destroy
  after_update :update_score_on_update

  def update_score_on_update
    if saved_changes.include? :vote
      ApplicationHelper.update_score_of(
        [user, question],
        vote_value * 2 # Counts double to undo the current vote
      )
    end
  end

  def update_scores_on_create
    ApplicationHelper.update_score_of(
      [user, question],
      vote_value
    )
  end

  def update_score_on_destroy
    ApplicationHelper.update_score_of(
      [user, question],
      -vote_value # Negative value to undo the current vote
    )
  end
end
