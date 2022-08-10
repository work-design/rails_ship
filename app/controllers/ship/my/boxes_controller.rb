module Ship
  class My::BoxesController < My::BaseController
    before_action :set_box, only: [:show, :edit, :update, :destroy, :actions, :owned_show]

    def index
      @boxes = current_user.boxes.includes(:box_specification).order(id: :desc).page(params[:page])
    end

    def owned
      @boxes = current_user.owned_boxes.includes(:box_specification).order(id: :desc).page(params[:page])
    end

    def owned_show
    end

    private
    def set_box
      @box = Box.find params[:id]
    end

    def rental_params
      params.fetch(:financial, {}).permit(
        :cost,
        :logo
      )
    end

  end
end
