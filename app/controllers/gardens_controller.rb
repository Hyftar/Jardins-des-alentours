class GardensController < ApplicationController
  before_action :authenticate_user!, only: %i( edit update new create destroy own_gardens )

  before_action :get_garden, only: %i( show )
  before_action :is_owner, only: %i( destroy edit update )
  before_action :get_user_gardens, only: %i( own_gardens )

  def show
  end

  def index
  end

  def new
    @garden = Garden.new
    @garden.build_location
  end

  def create
    # Search array for Geocoder
    @search = [
      garden_param["location_attributes"]["house_number"],
      garden_param["location_attributes"]["road"],
      garden_param["location_attributes"]["city"],
      garden_param["location_attributes"]["province"],
      garden_param["location_attributes"]["country"]
    ].compact.join(", ")

    # All Geocoder results are saved in locations. They are then sent back to the user by ajax
    @results = Geocoder.search(@search)
    @locations = []
    @results.each do|geo|
      @location = Location.create(
        house_number: geo.house_number,
        road: geo.street,
        neighbourhood: geo.data["address"]["neighbourhood"],
        additional_informations: garden_param["location_attributes"]["additional_informations"],
        region: geo.data["address"]["region"],
        county: geo.data["address"]["county"],
        city: geo.city,
        province: geo.state,
        country: geo.country,
        country_code: geo.country_code,
        postal_code: geo.postal_code,
        latitude: geo.latitude,
        longitude: geo.longitude
      )
      @locations << @location
    end

    respond_to do |format|
      format.html{ render partial: "address_choice" }
    end
  end

  # The garden is created using the selected location
  def create_garden
    @location = Location.find(params["location"]);
    @garden = Garden.new(name: params["name"], description: params["description"], user: current_user, location: @location)
    if @garden.save
      data = {
        :url => request.base_url + "/gardens/" + @garden.id.to_s
      }
      render :json => data
    else
      ActiveRecord::Rollback
    end
  end

  def destroy
    @garden_variety = GardenVariety.where(garden: params[:id])
    Market.where(garden_variety: @garden_variety).destroy_all
    @garden_variety.destroy_all
    @garden.destroy
    redirect_to gardens_path
  end

  def edit
  end

  def update
    if @garden.update(garden_param)
      redirect_to action: "show", id: @garden
    else
      render action: "edit"
    end
  end

  def index_own
  end

  # Find gardens near the visitor submitted address
  def find_near_address
    @address = Geocoder.search(params["address"])
    unless @address.empty?
      @gardens = if params["markets"] == "true"
        Location.near(
          @address.first.coordinates,params["distance"],
          units: :km, select: "gardens.*, locations.*, gardens.id AS garden_id"
        ).joins(garden: :markets)
      else
        Location.near(
          @address.first.coordinates,
          params["distance"],
          units: :km,
          select: "gardens.*, locations.*, gardens.id AS garden_id"
        ).joins(:garden)
      end
      render json: { garden: @gardens, latitude: @address.first.latitude, longitude: @address.first.longitude, message: I18n.t("landing_page.no_address"), url: request.base_url + "/gardens/"}
    else
      render json: { message: I18n.t("landing_page.address_not_found") }
    end
  end

  # Find gardens near the visitor submitted position, using HTML5 Geolocation
  def find_near_position
    if params["markets"] == "true"
      @gardens = Location.near(
        [
          params["latitude"],
          params["longitude"]
        ],
        params["distance"],
        units: :km,
        select: "gardens.*, locations.*, gardens.id AS garden_id"
      ).joins(garden: :markets)
    else
      @gardens = Location.near(
        [
          params["latitude"],
          params["longitude"]
        ],
        params["distance"],
        units: :km,
        select: "gardens.*, locations.*, gardens.id AS garden_id"
      ).joins(:garden)
    end
    render json: { garden: @gardens, message: I18n.t("landing_page.no_location"), url: request.base_url + "/gardens/", edit: request.base_url + "/" }
  end

  def own_gardens
  end

  private
    def get_garden
      @garden = Garden.includes(:location, garden_varieties: [:markets, :variety]).find(params[:id])
      if user_signed_in?
        @market_notifications = MarketNotification.where(email: current_user.email).map { |m| [m.market_id, m.status] }
      else
        @market_notifications
      end
    end

    def get_user_gardens
      @gardensUser = Garden.where(user: current_user)
    end

    def get_gardens
      @allGardens = Garden.all
    end

    def garden_param
      params.require(:garden).permit(:name, :description, location_attributes: %i( house_number road additional_informations city province country postal_code))
    end

    def is_owner
      @garden = Garden.find_by!(id: params[:id], user: current_user)
    end
end
