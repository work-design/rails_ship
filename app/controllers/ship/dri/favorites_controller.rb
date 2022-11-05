module Ship
  class Dri::FavoritesController < Dri::BaseController
    before_action :set_favorite, only: [:show, :edit, :update, :destroy]

    def index
      @favorites = current_driver.favorites.includes(:user).page(params[:page])
    end

    private
    def set_favorite
      @favorite = current_driver.favorites.find(params[:id])
    end

    def favorite_params
      params.fetch(:favorite, {}).permit(
        :remark
      )
    end

  end
end
