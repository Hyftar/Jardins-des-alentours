class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: %i( vote_up vote_down remove_vote )
  before_action :get_community
  before_action :get_question, only: %i( show )
  before_action :get_questions, only: %i( index )
  before_action :get_user_vote, only: %i( vote_up vote_down remove_vote )

  def vote_up
    if @vote.nil?
      QuestionVote.create(
        user: current_user,
        question: @question,
        vote: :up
      )
    else
      @vote.up!
      @vote.save!
    end

    render json: { score_value: @question.reload.score }
  end

  def vote_down
    if @vote.nil?
      QuestionVote.create(
        user: current_user,
        question: @question,
        vote: :down
      )
    else
      @vote.down!
      @vote.save!
    end

    render json: { score_value: @question.reload.score }
  end

  def remove_vote
    @vote.destroy! unless @vote.nil?

    render json: { score_value: @question.reload.score }
  end

  def index
  end

  def show
  end

  private
    def get_user_vote
      @question = Question.find_by!(id: params[:question_id])
      @vote =
        QuestionVote.find_by(
          user: current_user,
          question: @question
        )
    end

    def get_question
      @question =
        Question
          .includes(:user)
          .find_by!(id: params[:id], community: @community)
    end

    def get_community
      @community = Community.find(params[:community_id])
    end

    def get_questions
      @questions =
        Question
          .includes(:user)
          .where(community: @community)
          .order(created_at: :desc, status: :asc)
          .paginate(page: params[:page], per_page: 15)
    end
end
