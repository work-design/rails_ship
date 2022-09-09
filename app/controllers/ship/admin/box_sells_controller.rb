module Ship
  class Admin::BoxSellsController < Admin::BaseController
    before_action :set_box_proxy_sell

    def index
      @box_sells = @box_proxy_sell.box_sells.page(params[:page])
    end

    private
    def set_box_proxy_sell
      @box_proxy_sell = BoxProxySell.find params[:box_proxy_sell_id]
    end
  end
end
