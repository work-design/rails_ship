class Ship::Admin::RalliesController < Ship::Admin::BaseController
  before_action :set_rally, only: [:show, :join, :edit, :update, :destroy]

  def index
    @rallies = current_user.rallies.page(params[:page])
  end

  def new
    @rally = current_user.rallies.build
  end

  def create
    @rally = current_user.rallies.build(rally_params)

    if @rally.save
      render 'create', locals: { return_to: my_rallies_url }
    else
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
