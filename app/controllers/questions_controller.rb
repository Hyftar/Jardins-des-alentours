class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: %i( vote_up vote_down remove_vote )
  before_action :get_community
  before_action :get_question, only: %i( show vote_up vote_down remove_vote )
  before_action :get_questions, only: %i( index )

  def vote_up
  end

  def vote_down
  end

  def remove_vote
  end

  def index
  end

  def show
  end

  private
    def get_question
      @question =
        Question
          .includes(:user)
          .find_by(id: params[:id], community: @community)
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
