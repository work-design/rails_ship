module Ship
  class My::ItemsController < My::BaseController
    before_action :set_box_hold
    before_action :set_item, only: [:show, :actions]

    def index
      @items = @box_hold.items.includes(:order).aim_use.order(id: :desc).page(params[:page])
    end

    def rent
      @items = @box_hold.items.includes(:order).aim_rent.deliverable.order(id: :desc).page(params[:page])
    end

    private
    def set_box_hold
      @box_hold = BoxHold.find params[:box_hold_id]
    end

    def set_item
      @item = @box_hold.items.find params[:id]
    end

  end
end
