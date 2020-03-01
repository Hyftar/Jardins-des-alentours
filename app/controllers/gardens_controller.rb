class GardensController < ApplicationController
  before_action :authenticate_user!, only: %i( index_own edit update new create )

  before_action :get_user_gardens, only: %i( indexId )
  before_action :get_gardens, only: %i( index )
  before_action :get_garden, only: %i( show )
  before_action :valid_user, only: %i( destroy edit update )


  def indexId
  end

  def show
  end

  def index
  end

  def new
    @garden = Garden.new
  end

  def create
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
       redirect_to :action => 'show', :id => @garden
    else
       render :action => 'edit'
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
      @gardens = Garden.all
    end

    def garden_param
      params.require(:garden).permit(:name, :description)
    end

    def valid_user
      @garden = Garden.find_by!(id: params[:id], user: current_user)
    end

end
