module Ship
  class My::BoxesController < My::BaseController

    def index
      @boxes = current_user.boxes.order(id: :desc).page(params[:page])
    end

    private
    def rental_params
      params.fetch(:financial, {}).permit(
        :cost,
        :logo
      )
    end

  end
end
