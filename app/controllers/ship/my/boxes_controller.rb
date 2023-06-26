module Ship
  class My::BoxesController < My::BaseController
    before_action :set_box_hold, only: [:index, :owned]
    before_action :set_box, only: [:show, :edit, :update, :destroy, :actions, :owned_show, :qrcode, :start, :start_create]
    before_action :ensure_box_hold, only: [:qrcode, :start]

    def index
      @boxes = @box_hold.boxes.order(id: :desc).page(params[:page])
    end

    def owned
      @boxes = current_user.boxes.includes(:box_specification).where(rented: false).order(id: :desc).page(params[:page])
    end

    def invest
      @boxes = current_user.boxes.rentable.includes(:box_specification).order(id: :desc).page(params[:page])
    end

    def owned_show
    end

    def qrcode
    end

    def start
      item = current_user.items.find params[:item_id]
      @box.do_rent(item)
    end

    private
    def set_box_hold
      @box_hold = BoxHold.find params[:box_hold_id]
    end

    def set_box
      @box = Box.find params[:id]
    end

    def ensure_box_hold
      q_params = {
        box_specification_id: @box.box_specification_id,
        user_id: current_user.id
      }
      q_params.merge! default_params

      @box_hold = BoxHold.find_or_create_by(q_params)
    end

    def rental_params
      params.fetch(:financial, {}).permit(
        :cost,
        :logo
      )
    end

  end
end
