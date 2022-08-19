module Ship
  class My::BoxesController < My::BaseController
    before_action :set_box, only: [:show, :edit, :update, :destroy, :actions, :owned_show, :qrcode]

    def index
      @boxes = current_user.boxes.includes(:box_specification).order(id: :desc).page(params[:page])
    end

    def owned
      @boxes = current_user.owned_boxes.where(rentable: false).includes(:box_specification).order(id: :desc).page(params[:page])
    end

    def invest
      @boxes = current_user.owned_boxes.rentable.includes(:box_specification).order(id: :desc).page(params[:page])
    end

    def owned_show
    end

    def qrcode

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
