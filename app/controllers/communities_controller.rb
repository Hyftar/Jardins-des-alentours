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

  # get the search string input by the user, and looks for varieties with the same name
  # returns the corresponding community, or redirect to the communities index page
  def search_veggie
    search_string = params['find-favorite'].downcase
    @community = Community
                     .includes(:variety)
                     .where("lower(varieties.name) LIKE ?", "%#{search_string}%")
                     .order(score: :desc)
                     .first
    if @community.blank? | search_string.empty?
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

      # prepare information for community page
      # define months to show the min their proper format according to the variety culture season
      months = [t('jan'), t('feb'), t('mar'), t('apr'),
                t('may'), t('jun'), t('jul'), t('aug'),
                t('sep'), t('oct'), t('nov'), t('dec')]
      s_months = (@community.variety.culture_start.month..@community.variety.culture_end.month).to_a
      @s_start = months[s_months.first - 1]
      @s_end = months[s_months.last - 1]

      # define exposures for proper formatting and choose the right one
      exposures = [t('shadow'), t('half_exposed'), t('fully_exposed')]
      e_icons = %w(fa-cloud fa-cloud-sun fa-sun)
      @exposure = exposures[@community.variety.sun_exposure_before_type_cast]
      @e_icon = e_icons[@community.variety.sun_exposure_before_type_cast]

      @subvarieties = Variety.where(parent_id: params[:id])

      @gardens = Garden.all.first(4)
    end

    def get_10_most_relevant_communities
      @communities = Community.order(score: :desc).limit(10)
      # build a seasons hash linking communities with an array of their corresponding seasons
      # will be used the print the seasons for each community
      @seasons = Hash[@communities.map { |community|
        seasons = []
        months = (community.variety.culture_start.month..community.variety.culture_end.month).to_a
        seasons.push('winter') if (months & [11, 12, 1, 2]).any?
        seasons.push('spring') if (months & [2, 3, 4, 5]).any?
        seasons.push('summer') if (months & [5, 6, 7, 8]).any?
        seasons.push('fall') if (months & [8, 9, 10, 11]).any?
        [community, seasons]
      }]
      # build a continents hash linking communities with their corresponding continent
      @communities_continents = Hash[@communities.map { |community|
        continent = Country.find_by(name: community.location.country).continent
        [community, continent]
      }]
      # define what to print for a specific continent
      @continents = Hash.new
      @continents["North America"] = "tag-1"
      @continents["Europe"] = "tag-2"
      @continents["South America"] = "tag-3"
      @continents["Africa"] = "tag-4"
      @continents["Asia"] = "tag-5"
      @continents["Oceania"] = "tag-6"
    end
end
