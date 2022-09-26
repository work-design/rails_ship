module Ship
  class Admin::BoxProxySellsController < Admin::BaseController
    before_action :set_box_host

    def index
      @box_proxy_sells = @box_host.box_proxy_sells.order(price: :asc).page(params[:page])
    end

    private
    def set_box_host
      @box_host = BoxHost.find params[:box_host_id]
    end
  end
end
