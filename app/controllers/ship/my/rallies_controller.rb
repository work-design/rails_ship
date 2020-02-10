class Ship::My::RalliesController < Ship::My::BaseController
  before_action :set_rally, only: [:show, :edit, :update, :destroy]

  def index
    @rallies = Rally.page(params[:page])
  end

  def new
    @rally = Rally.new
  end

  def create
    @rally = Rally.new(rally_params)

    unless @rally.save
      render :new, locals: { model: @rally }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @rally.assign_attributes(rally_params)

    unless @rally.save
      render :edit, locals: { model: @rally }, status: :unprocessable_entity
    end
  end

  def destroy
    @rally.destroy
  end

  private
  def set_rally
    @rally = Rally.find(params[:id])
  end

  def rally_params
    params.fetch(:rally, {}).permit(
      :name,
      :detail,
      :area_id
    )
  end

end
