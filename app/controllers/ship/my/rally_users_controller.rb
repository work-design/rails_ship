class Ship::My::RallyUsersController < Ship::My::BaseController
  before_action :set_rally

  def index
    @rally_users = @rally.rally_users.page(params[:page])
  end

  def new
    @rally_user = @rally.rally_users.build
  end

  def create
    @rally_user = @rally.rally_users.build(user_id: user.id)

    if @rally_user.save
      render 'create', locals: { return_to: my_rallies_url }
    else
      render :new, locals: { model: @rally_user }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @rally_user.assign_attributes(rally_user_params)

    unless @rally_user.save
      render :edit, locals: { model: @rally_user }, status: :unprocessable_entity
    end
  end

  def destroy
    @rally_user.destroy
  end

  private
  def set_rally
    @rally = Rally.find(params[:rally_id])
  end

  def rally_user_params
    params.fetch(:rally_user, {}).permit(
      :user_id,
      :state
    )
  end

end
