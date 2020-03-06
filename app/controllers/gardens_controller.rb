class GardensController < ApplicationController
  before_action :authenticate_user!, only: %i( edit update new create destroy )

  before_action :get_gardens, only: %i( index )
  before_action :get_garden, only: %i( show )
  before_action :is_owner, only: %i( destroy edit update )

  def show
  end

  def index
  end

  def new
    @garden = Garden.new
    @garden.build_location
  end

  def create
    @location = Location.new(
      house_number: garden_param["location_attributes"]["house_number"],
      road: garden_param["location_attributes"]["road"],
      additional_informations: garden_param["location_attributes"]["additional_informations"],
      city: garden_param["location_attributes"]["city"],
      province: garden_param["location_attributes"]["province"],
      country: garden_param["location_attributes"]["country"],
      postal_code: garden_param["location_attributes"]["postal_code"])
    @garden = Garden.new(name: garden_param["name"], description: garden_param["description"], user: current_user, location: @location)
    if @location.save && @garden.save
      redirect_to :action => 'show', :id => @garden
    else
      ActiveRecord::Rollback
      render :action => 'new'
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
    if @garden.update_attributes(garden_param)
      redirect_to action: "show", id: @garden
    else
      render action: "edit"
    end
  end

  def index_own
    @gardens = Garden.where(user: current_user)
  end

  private
    def get_garden
      @garden = Garden.find(params[:id])
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
