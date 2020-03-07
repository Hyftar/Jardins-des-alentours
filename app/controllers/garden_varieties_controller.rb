class GardenVarietiesController < ApplicationController
  before_action :get_garden_variety, only: %i( edit update destroy set_active )

  def new
    @garden = Garden.find_by!(user: current_user, id: params[:garden_id])
    @garden_varieties = GardenVariety.where(garden_id: @garden.id)
    @varieties = Variety.find_varieties_unused_in_garden(@garden.id)
    @garden_variety = GardenVariety.new
  end

  # how to get varieties not in garden_varieties for this garden

  def create
    @variety = Variety.find_by!(id: params["garden_variety"]["variety"])
    @garden = Garden.find_by!(id: params["garden_variety"]["garden"], user: current_user)
    if !GardenVariety.find_by(garden: @garden, variety: @variety) && GardenVariety.create(garden: @garden, variety: @variety)
      redirect_to garden_path(@garden)
    else
      @garden_variety = GardenVariety.new
      render action: "new"
    end
  end

  def set_active
    @garden_variety.is_active = !@garden_variety.is_active
    @garden_variety.save
    redirect_to garden_path(@garden)
  end

  private
    def market_param
      params.require(:garden_variety).permit(:quantity, :unit)
    end

    def get_garden_variety
      @garden_variety = GardenVariety.find_by!(id: params[:garden_variety_id])
      @garden = Garden.find_by!(id: @garden_variety.garden, user: current_user)
    end
end
