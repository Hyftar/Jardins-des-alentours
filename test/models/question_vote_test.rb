require "test_helper"

class QuestionVoteTest < ActiveSupport::TestCase
  test "points should be added on positive vote creation and removed on deletion" do
    u = users(:one)
    q = questions(:one)

    user_score_before = u.score
    question_score_before = q.score

    vote = QuestionVote.create(
      question: q,
      user: u,
      vote: :up
    )

    user_score_after = u.score
    question_score_after = q.score

    assert_equal user_score_before + 1, user_score_after, "User score has not been incremented"
    assert_equal question_score_before + 1, question_score_after, "Question score has not been incremented"

    # Updating the vote
    vote.down!

    user_score_after = u.score
    question_score_after = q.score

    assert_equal user_score_before - 1, user_score_after, "User score has not been incremented"
    assert_equal question_score_before - 1, question_score_after, "Question score has not been incremented"

    vote.destroy!

    user_score_after = u.score
    question_score_after = q.score

    assert_equal user_score_before, user_score_after, "User score has not been reset"
    assert_equal question_score_before, question_score_after, "Question score has not been reset"
  end

  test "points should be removed on negative vote creation and added on deletion" do
    u = users(:one)
    q = questions(:one)

    user_score_before = u.score
    question_score_before = q.score

    vote = QuestionVote.create(
      question: q,
      user: u,
      vote: :down
    )

    user_score_after = u.score
    question_score_after = q.score

    assert_equal user_score_before - 1, user_score_after, "User score has not been incremented"
    assert_equal question_score_before - 1, question_score_after, "Question score has not been incremented"

    # Updating the vote
    vote.up!

    user_score_after = u.score
    question_score_after = q.score

    assert_equal user_score_before + 1, user_score_after, "User score has not been decremented"
    assert_equal question_score_before + 1, question_score_after, "Question score has not been decremented"

    vote.destroy!

    user_score_after = u.score
    question_score_after = q.score

    assert_equal user_score_before, user_score_after, "User score has not been reset"
    assert_equal question_score_before, question_score_after, "Question score has not been reset"
  end
end
