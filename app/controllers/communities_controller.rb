class CommunitiesController < ApplicationController
  before_action :get_10_most_relevant_communities, only: %i( index )
  before_action :get_community_info, only: %i( show )

  def index
  end

  def show
  end

  private
    def get_community_info
      @community = Community.find_by!(id: params[:id])
    end

    def get_10_most_relevant_communities
      @communities = Community.order(score: :desc).limit(10)
    end
end
