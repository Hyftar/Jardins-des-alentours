class QuestionController < ApplicationController
  before_action :authenticate_user!


  def vote_up
  end

  def vote_down
  end

  def remove_vote
  end

  private
    def get_question
      @question = Question.find(params[:id])
    end
end
