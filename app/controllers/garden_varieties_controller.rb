class GardenVarietiesController < ApplicationController
  before_action :get_garden_variety, only: %i( edit update destroy set_active )

  def new
    GardenVariety.new
  end

  def create
  end

  def edit
  end

  def update
    if @garden_variety.update_attributes(garden_variety_param)
      redirect_to garden_path(@garden_variety.garden)
    else
      render action: "edit"
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
