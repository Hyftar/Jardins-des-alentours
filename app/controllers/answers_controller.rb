class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :get_question

  def create
    @answer = Answer.create!(
      user: current_user,
      content: permit_params,
      question: @question
    )

    redirect_to community_question_path(
      community_id: @question.community_id,
      id: @question.id
    )
  end

  private
    def get_question
      @question = Question.find_by!(id: params[:question_id])
    end

    def permit_params
      params.require(:content)
    end

end
