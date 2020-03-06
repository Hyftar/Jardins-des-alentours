class MarketsController < ApplicationController
  before_action :is_owner, only: %i( edit update destroy )
  before_action :is_owner_new_market, only: %i( new create )

  def new
    @garden_variety = GardenVariety.find_by!(id: params[:id], is_active: true)
    @market = Market.new
  end

  def create
    @garden_variety = GardenVariety.find_by!(id: params["market"]["garden_variety"], is_active: true)
    if Market.create(quantity: market_param["quantity"], unit: market_param["unit"], garden_variety: @garden_variety)
      redirect_to garden_path(@garden_variety.garden)
    else
       render :action => 'new'
    end
  end

  def edit
  end

  def update
    @market_original = @market.dup
    if @market.update(market_param)
      if @market_original.unit != @market.unit || @market_original.quantity != @market.quantity
        @market_notifications = MarketNotification.where(market: @market)
        @market_notifications.each do |notification|
          MarketMailer.with(market: @market, market_notification: notification).market_disponibility_update_email.deliver_later
        end
      end
      redirect_to garden_path(@market.garden_variety.garden)
    else
       render :action => 'edit'
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
      params.require(:market).permit(:quantity, :unit, :is_active, :garden_variety)
    end

    def is_owner
      @market = Market.find_by!(id: params[:id])
      @garden_variety = GardenVariety.find_by!(id: @market.garden_variety)
      @garden = Garden.find_by!(id: @garden_variety.garden, user: current_user)
    end

    def is_owner_new_market
      @garden = Garden.find_by!(id: params[:garden_id])
    end

end
