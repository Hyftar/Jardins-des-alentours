class VarietiesController < ApplicationController
  before_action { authorize_user! "admin" }

  def index
    @varieties = Variety.includes(:parent).all
  end

  def show
    @variety = Variety.find(params[:id])
  end

  def edit
    @variety = Variety.find(params[:id])
    @available_varieties = Variety.where.not(id: @variety.id)
  end

  def update # POST from edit
    @variety = Variety.find(params[:id])
    if @variety.update(varieties_params)
      redirect_to @variety
    else
      @available_varieties = Variety.all
      render "edit"
    end
  end

  def new
    @variety = Variety.new
    @available_varieties = Variety.all
  end

  def create
    @variety = Variety.new(varieties_params)
    if @variety.save
      redirect_to @variety
    else
      @available_varieties = Variety.all
      render "new"
    end
  end

  def destroy
    @variety = Variety.find(params[:id])
    @variety.destroy!
    redirect_to varieties_path
  end

  private
    def varieties_params
      params.require(:variety).permit(
        :name,
        :description,
        :score,
        :created_at,
        :updated_at,
        :latin_name,
        :spacing,
        :height,
        :family,
        :hardiness_zone,
        :germination_time,
        :culture_start,
        :freeze_resistance,
        :culture_end,
        :sun_exposure,
        :parent_id,
        :image,
        planting_method: []
      )
    end

end
