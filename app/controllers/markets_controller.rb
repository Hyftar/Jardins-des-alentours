class MarketsController < ApplicationController
  before_action :validate_user, only: %i( edit update destroy )

  def new
    Market.new
  end

  def create
  end

  def edit
  end

  def update
    if @market.update_attributes(market_param)
      redirect_to garden_path(@market.garden_variety.garden)
    else
      render action: "edit"
    end
  end

  def set_active
    @market = Market.find_by!(id: params[:market_id])
    @garden_variety = GardenVariety.find_by!(id: @market.garden_variety)
    @garden = Garden.find_by!(id: @garden_variety.garden, user: current_user)
    @market.is_active = !@market.is_active
    @market.save
    redirect_to garden_path(@garden)
  end

  def destroy
    @garden = @market.garden_variety.garden
    @market.destroy
    redirect_to garden_path(@garden)
  end

  private
    def market_param
      params.require(:market).permit(:quantity, :unit)
    end

    def validate_user
      @market = Market.find_by!(id: params[:id])
      @garden_variety = GardenVariety.find_by!(id: @market.garden_variety)
      @garden = Garden.find_by!(id: @garden_variety.garden, user: current_user)
    end
end
