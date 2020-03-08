class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: %i( select_answer vote_up vote_down remove_vote )
  before_action :get_community
  before_action :get_question, only: %i( show )
  before_action :get_questions, only: %i( index )
  before_action :get_user_vote, only: %i( vote_up vote_down remove_vote )
  before_action :get_user_question_and_answer, only: %i( select_answer )

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    @question.community = @community
    @question.save!
    redirect_to community_questions_path(@community)
  end

  def select_answer
    if @question.nil? || @answer.nil? || @question.deleted? || @question.removed?
      render status: :bad_request, json: { selected: nil }
    end

    new_selected_answer = @question.selected_answer == @answer ? nil : @answer
    @question.selected_answer = new_selected_answer
    @question.status = new_selected_answer.present? ? :closed : :pending
    @question.save!
    render status: :ok, json: { selected: @question.selected_answer.present? }
  end

  def vote_up
    if @vote.nil?
      QuestionVote.create(
        user: current_user,
        question: @question,
        vote: :up
      )
    else
      @vote.up!
    end

    render json: {
      score: @question.reload.score,
      vote: "up" # Current user vote
    }
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
    end

    render json: {
      score: @question.reload.score,
      vote: "down" # Current user vote
    }
  end

  def remove_vote
    @vote.destroy! unless @vote.nil?

    render json: {
      score: @question.reload.score,
      vote: "none" # Current user vote
    }
  end

  def index
  end

  def show
    @answer = Answer.new
  end

  private
    def question_params
      params.require(:question).permit(:title, :content)
    end

    def get_user_question_and_answer
      @question =
        Question.find_by(
          id: params[:question_id],
          user: current_user
        )

      @answer =
        Answer.find_by(
          id: params[:answer_id],
          question: params[:question_id]
        )
    end

    def get_user_vote
      @question =
        Question.find_by!(
          id: params[:question_id],
          community: @community
        )

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
          .find_by!(id: params[:id], community: @community, status: %i( opened pending closed ))

      @current_user_has_not_yet_answered =
        !Answer
          .where(question: @question, user: current_user, status: :active)
          .exists?

      @answers = Answer.all_with_votes_from(current_user, @question)

      @vote =
        QuestionVote.find_by(
          user: current_user,
          question: @question
        )
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
          .paginate(page: params[:page], per_page: 10)
    end
end
