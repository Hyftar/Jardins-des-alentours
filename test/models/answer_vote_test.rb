require "test_helper"

class AnswerVoteTest < ActiveSupport::TestCase
  test "points should be added on positive vote creation and removed on deletion" do
    u = users(:one)
    q = answers(:one)

    user_score_before = u.score
    answer_score_before = q.score

    vote = AnswerVote.create(
      answer: q,
      user: u,
      vote: :up
    )

    user_score_after = u.score
    answer_score_after = q.score

    assert_equal user_score_before + 1, user_score_after, "User score has not been incremented"
    assert_equal answer_score_before + 1, answer_score_after, "Answer score has not been incremented"

    # Updating the vote
    vote.down!

    user_score_after = u.score
    answer_score_after = q.score

    assert_equal user_score_before - 1, user_score_after, "User score has not been incremented"
    assert_equal answer_score_before - 1, answer_score_after, "Answer score has not been incremented"

    vote.destroy!

    user_score_after = u.score
    answer_score_after = q.score

    assert_equal user_score_before, user_score_after, "User score has not been reset"
    assert_equal answer_score_before, answer_score_after, "Answer score has not been reset"
  end

  test "points should be removed on negative vote creation and added on deletion" do
    u = users(:one)
    q = answers(:one)

    user_score_before = u.score
    answer_score_before = q.score

    vote = AnswerVote.create(
      answer: q,
      user: u,
      vote: :down
    )

    user_score_after = u.score
    answer_score_after = q.score

    assert_equal user_score_before - 1, user_score_after, "User score has not been incremented"
    assert_equal answer_score_before - 1, answer_score_after, "Answer score has not been incremented"

    # Updating the vote
    vote.up!

    user_score_after = u.score
    answer_score_after = q.score

    assert_equal user_score_before + 1, user_score_after, "User score has not been decremented"
    assert_equal answer_score_before + 1, answer_score_after, "Answer score has not been decremented"

    vote.destroy!

    user_score_after = u.score
    answer_score_after = q.score

    assert_equal user_score_before, user_score_after, "User score has not been reset"
    assert_equal answer_score_before, answer_score_after, "Answer score has not been reset"
  end

  test "user should only be able to vote once per question" do
    user1 = users(:one)
    user2 = users(:two)
    a = answers(:one)

    AnswerVote.create(
      answer: a,
      user: user1,
      vote: :up
    ).save!

    assert_raise do
      AnswerVote.create(
        answer: a,
        user: user1,
        vote: :up
      ).save!
    end

    assert_nothing_raised do
      AnswerVote.create(
        answer: a,
        user: user2,
        vote: :up
      ).save!
    end
  end
end
