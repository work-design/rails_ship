module Ship
  class My::BoxesController < My::BaseController
    before_action :set_box, only: [:show, :edit, :update, :destroy, :actions, :owned_show, :qrcode, :start, :start_create]
    before_action :set_items, only: [:start]

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

    def set_items
      q_params = {
        good_id: @box.box_specification_id,
        good_type: 'Ship::BoxSpecification',
        delivery: ['init', 'partially']
      }
      q_params.merge! default_params

      @items = current_user.items.default_where(q_params)
    end

    def rental_params
      params.fetch(:financial, {}).permit(
        :cost,
        :logo
      )
    end

  end
end
