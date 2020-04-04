class CommunitiesController < ApplicationController
  before_action only: %i( new create ) do
    authorize_user!("admin")
  end

  before_action :get_10_most_relevant_communities, only: %i( index )
  before_action :get_community_info, only: %i( show )
  before_action :get_available_varieties, only: %i( new )

  def index
  end

  def show
  end

  def new
    @community = Community.new
    @location = Location.new
  end

  def create
    @community = Community.new(variety_id: community_params[:variety_id])
    community_params[:location]
      .select { |k, v| v.empty? }
      .each { |k, v| @community.errors.add(k, :blank) }

    if @community.errors.any?
      return render status: :bad_request, json: { errors: @community.errors }
    end

    @location = Location.new(community_params[:location])
    @community.location = @location

    if @community.save
      redirect_to community_path(@community)
    else
      return render status: :bad_request, json: { errors: @community.errors }
    end
  end

  private
    def community_params
      params.require(:community).permit(
        :variety_id,
        location: %i(
          longitude
          latitude
        )
      )
    end

    def get_available_varieties
      @varities = Variety.all
    end

    def get_community_info
      @community = Community.find_by!(id: params[:id])
    end

    def get_10_most_relevant_communities
      @communities = Community.order(score: :desc).limit(10)
    end
end
