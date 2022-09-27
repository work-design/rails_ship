module Ship
  class My::BoxSellsController < My::BaseController
    before_action :set_box_hold
    before_action :set_new_box_sell, only: [:create]

    def index
      @box_sells = @box_hold.box_sells.order(id: :desc).page(params[:page])
    end

    private
    def set_box_hold
      @box_hold = BoxHold.find params[:box_hold_id]
    end

    def set_new_box_sell
      @box_sell = @box_hold.box_sells.build(box_sell_params)
    end

    def box_sell_params
      params.fetch(:box_sell, {}).permit(
        :price,
        :amount
      )
    end

  end
end
