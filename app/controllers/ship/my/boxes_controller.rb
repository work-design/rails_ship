module Ship
  class My::BoxesController < My::BaseController
    before_action :set_box, only: [:show, :edit, :update, :destroy, :actions, :owned_show, :qrcode, :start, :start_create]
    before_action :set_items, only: [:start]

    def index
      @boxes = current_user.boxes.includes(:box_specification).where(rented: true).order(id: :desc).page(params[:page])
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
    end

    def start_create
      item = current_user.items.find params[:item_id]
      @box.do_rent(item)
    end

    private
    def set_box
      @box = Box.find params[:id]
    end

    def box_hold
      @box_hold
    end

    def set_items
      q_params = {
        box_specification_id: @box.box_specification_id,
        user_id: current_user.id
      }
      q_params.merge! default_params

      @box_hold = BoxHold.find_or_create_by(q_params)

      # delivery: ['init', 'partially']
      @items = @box_hold.items
    end

    def rental_params
      params.fetch(:financial, {}).permit(
        :cost,
        :logo
      )
    end

  end
end
