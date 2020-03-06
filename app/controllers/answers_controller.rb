class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :get_question
  before_action :get_answer, only: %i( update destroy )
  before_action :get_user_vote, only: %i( vote_up vote_down remove_vote )

  def create
    @answer = Answer.create!(
      user: current_user,
      content: answer_params[:content],
      question: @question
    )

    redirect_to community_question_path(
      community_id: @question.community_id,
      id: @question.id
    )
  end

  def destroy
    @answer.deleted!

    if @question.selected_answer == @answer
      @question.selected_answer = nil
      @question.save!
    end

    redirect_to community_question_path(
      community_id: @question.community_id,
      id: @question.id
    )
  end

  def update
    @answer.update!(answer_params)

    redirect_to community_question_path(
      community_id: @question.community_id,
      id: @question.id
    )
  end

  def vote_up
    if @vote.nil?
      AnswerVote.create(
        user: current_user,
        answer: @answer,
        vote: :up
      )
    else
      @vote.up!
    end

    render json: {
      score: @answer.reload.score,
      vote: "up" # Current user vote
    }
  end

  def vote_down
    if @vote.nil?
      AnswerVote.create(
        user: current_user,
        answer: @answer,
        vote: :down
      )
    else
      @vote.down!
    end

    render json: {
      score: @answer.reload.score,
      vote: "down" # Current user vote
    }
  end

  def remove_vote
    @vote.destroy! unless @vote.nil?

    render json: {
      score: @answer.reload.score,
      vote: "none" # Current user vote
    }
  end

  private
    def get_user_vote
      @answer = Answer.find_by(
        id: params[:answer_id],
        question_id: params[:question_id],
      )

      @vote = AnswerVote.find_by(
        user: current_user,
        answer: @answer
      )
    end

    def get_answer
      @answer = Answer.find_by!(
        id: params[:id],
        question: @question,
        user: current_user
      )
    end

    def get_question
      @question = Question.find_by!(
        id: params[:question_id],
        community_id: params[:community_id]
      )
    end

    def answer_params
      params.require(:answer).permit(:content)
    end
end
