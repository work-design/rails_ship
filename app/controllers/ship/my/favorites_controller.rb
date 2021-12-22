module Ship
  class My::FavoritesController < My::BaseController
    before_action :set_favorite, only: [:show, :edit, :update, :destroy]

    def index
      @favorites = current_user.favorites.page(params[:page])
    end

    private
    def set_favorite
      @favorite = current_user.favorites.find(params[:id])
    end

    def favorite_params
      params.fetch(:favorite, {}).permit(
        :driver_avatar,
        :driver_name
      )
    end

  end
end
