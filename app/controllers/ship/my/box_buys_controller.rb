module Ship
  class My::BoxBuysController < My::BaseController
    before_action :set_box_hold
    before_action :set_new_box_buy, only: [:create]

    private
    def set_box_hold
      @box_hold = BoxHold.find params[:box_hold_id]
    end

    def set_new_box_buy
      @box_buy = @box_hold.box_buys.build(box_buy_params)
    end

    def box_buy_params
      params.fetch(:box_buy, {}).permit(
        :price,
        :amount
      )
    end
  end
end
