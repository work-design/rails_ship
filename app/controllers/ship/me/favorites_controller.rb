module Ship
  class Me::FavoritesController < Me::BaseController
    before_action :set_favorite, only: [:show, :edit, :update, :destroy]

    def index
      @favorites = current_member.favorites.includes(:user).page(params[:page])
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
