class MarketNotificationsController < ApplicationController
  before_action :authenticate_user!, only: %i( create_from_user )
  before_action :is_owner, only: %i( create_from_user )

  def new
    @market = Market.find_by!(id: params["market_id"])
    @garden = Garden.find_by!(id: params["garden_id"])
    if user_signed_in?
      self.create_from_user(@market, @garden)
    end
    @market_notification = MarketNotification.new
  end

  def create_from_user(market, garden)
    @market_existing = MarketNotification.where(market: @market, email: current_user.email)
    if @market_existing.length == 0
      @market_notification = MarketNotification.create(market: market, email: current_user.email, language: current_user.language)
    end
    redirect_to garden_path(@garden)
  end

  def create
    @garden = Garden.find_by!(id: market_param["garden"])
    @market = Market.find_by!(id: market_param["market"])
    @market_existing = MarketNotification.where(market: @market, email: market_param["email"])
    if !user_signed_in? && @market_existing.length == 0
      @market_notification = MarketNotification.create(market: @market, email: market_param["email"], language: locale)
    end
    redirect_to garden_path(@garden)
  end

  def status
    @market = Market.find_by!(id: params["market_id"])
    @garden = Garden.find_by!(id: params["garden_id"])
    @market_notification = MarketNotification.find_by!(market: @market, email: current_user.email)
    @market_notification.status == "active" ? @market_notification.status = "paused" : @market_notification.status = "active"
    @market_notification.save
    redirect_to garden_path(@garden)
  end

  private
    def market_param
      params.require(:market_notification).permit(:garden, :market, :email)
    end

    def is_owner
      @garden = Garden.find_by(id: market_param["garden"])
      if current_user == @garden.user
        redirect_to garden_path(@garden)
      end
    end
end
