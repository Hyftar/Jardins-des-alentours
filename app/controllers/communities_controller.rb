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

  def search_veggie
    search_string = params['find-favorite'].downcase
    @community = Community
                     .joins(:variety)
                     .where("lower(varieties.name) LIKE ?", "%#{search_string}%")
                     .order(score: :desc)
                     .first
    if @community.blank?
      redirect_to communities_path
    else
      redirect_to community_path(@community)
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
      months = [t('jan'), t('feb'), t('mar'), t('apr'),
                t('may'), t('jun'), t('jul'), t('aug'),
                t('sep'), t('oct'), t('nov'), t('dec')]
      s_months = (@community.variety.culture_start.month..@community.variety.culture_end.month).to_a
      @s_start = months[s_months.first - 1]
      @s_end = months[s_months.last - 1]
      exposures = [t('shadow'), t('half_exposed'), t('fully_exposed')]
      e_icons = %w(fa-cloud fa-cloud-sun fa-sun)
      @exposure = exposures[@community.variety.sun_exposure_before_type_cast]
      @e_icon = e_icons[@community.variety.sun_exposure_before_type_cast]
    end

    def get_10_most_relevant_communities
      @communities = Community.order(score: :desc).limit(10)
      @seasons = Hash[@communities.map { |community|
        seasons = []
        months = (community.variety.culture_start.month..community.variety.culture_end.month).to_a
        seasons.push('winter') if (months & [11, 12, 1, 2]).any?
        seasons.push('spring') if (months & [2, 3, 4, 5]).any?
        seasons.push('summer') if (months & [5, 6, 7, 8]).any?
        seasons.push('fall') if (months & [8, 9, 10, 11]).any?
        [community, seasons]
      }]
    end
end
