module Ship
  class Driver::FavoritesController < Driver::BaseController
    before_action :set_favorite, only: [:show, :edit, :update, :destroy]

    def index
      @favorites = current_driver.favorites.includes(:user).page(params[:page])
    end

    def show
    end

    def edit
    end

    def update
      @favorite.assign_attributes(favorite_params)

      unless @favorite.save
        render :edit, locals: { model: @favorite }, status: :unprocessable_entity
      end
    end

    def destroy
      @favorite.destroy
    end

    private
    def set_favorite
      @favorite = Favorite.find(params[:id])
    end

    def favorite_params
      params.fetch(:favorite, {}).permit(
        :remark
      )
    end

  end
end
