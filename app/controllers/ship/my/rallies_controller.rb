class Ship::My::RalliesController < Ship::My::BaseController
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

  def share

  end

  def join
    ru = current_user.rally_users.find_or_initialize_by(rally_id: @rally.id)
    ru.save
    render 'show'
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
