class MarketsController < ApplicationController
  before_action :is_owner, only: %i( edit update )
  before_action :is_owner_new_market, only: %i( new create )

  def new
    @garden_variety = GardenVariety.find_by!(id: params[:id], is_active: true)
    @market = Market.new
  end

  def create
    @garden_variety = GardenVariety.find_by!(id: market_param["garden_variety"], is_active: true)
    if Market.create(quantity: market_param["quantity"], unit: market_param["unit"], garden_variety: @garden_variety, price: params["price"])
      redirect_to garden_path(@garden_variety.garden)
    else
      render action: "new"
    end
  end

  def edit
  end

  def update
    @market_original = @market.dup
    if @market.update(quantity: market_param["quantity"], unit: market_param["unit"], price: params["price"])
      if @market_original.unit != @market.unit || @market_original.quantity != @market.quantity || @market_original.is_active != @market.is_active
        @market_notifications = MarketNotification.where(market: @market, status: "active")
        @market_notifications.each do |notification|
          MarketMailer.with(market: @market, market_notification: notification).market_disponibility_update_email.deliver_later
        end
      end
      redirect_to garden_path(@market.garden_variety.garden)
    else
      render action: "edit"
    end
  end

  def set_active
    @market = Market.find_by!(id: params["market_id"])
    @garden_variety = GardenVariety.find_by!(id: @market.garden_variety)
    @garden = Garden.find_by!(id: @garden_variety.garden, user: current_user)
    @market_original = @market.dup
    @market.is_active = !@market.is_active
    @market.save
    redirect_to garden_path(@garden)
  end

  def destroy
    @garden = @market.garden_variety.garden
    MarketNotification.where(market: @market).destroy
    @market.destroy
    redirect_to garden_path(@garden)
  end

  def write_email
    @garden = Garden.includes(:location, garden_varieties: [:markets, :variety]).find(params[:garden_id])
    render action: "write_email"
  end

  def send_email
    @garden = Garden.includes(:location, garden_varieties: [:markets, :variety]).find(params[:garden_id])
    @list_checkbox = []
    if params["checkbox"].present?
      params["checkbox"].each do |key, value|
        @list_checkbox << key
      end
    end
    @message = params["description"]
    if user_signed_in?
      @email = params["email"]
    else
      @email = params["email"]["user"]
    end
    if @email != @garden.user.email
      if user_signed_in?
        UserMessage.save_user_message(@message, current_user, @garden.user)
      else
        save_visitor_email(@email)
        VisitorMessage.save_visitor_message(@message, @visitor_email, @garden.user)
      end
      MarketMailer.with(garden: @garden, varieties: @list_checkbox, message: @message, email: @email).market_inquiry_email.deliver_later
    end
    redirect_to garden_path(@garden)
  end

  private
    def market_param
      params.require(:market).permit(:quantity, :unit, :is_active, :price, :garden_variety)
    end

    def is_owner
      @market = Market.find_by!(id: params[:id])
      @garden_variety = GardenVariety.find_by!(id: @market.garden_variety)
      @garden = Garden.find_by!(id: @garden_variety.garden, user: current_user)
    end

    def is_owner_new_market
      @garden = Garden.find_by!(id: params[:garden_id])
    end

    def save_visitor_email(email)
      ip = request.remote_ip
      @visitor = Visitor.find_by(IP: ip)
      if @visitor.nil?
        @visitor = Visitor.create(IP: ip)
        results = Geocoder.search(@visitor.IP)
        @visitor_location = VisitorLocation.create(longitude: results.first.coordinates.second, latitude: results.first.coordinates.first, visitor: @visitor)
      end
      @visitor_email = VisitorEmail.find_by(email: email, visitor: @visitor)
      if @visitor_email.nil?
        @visitor_email =VisitorEmail.create(email: email, visitor: @visitor)
      end
    end

end
