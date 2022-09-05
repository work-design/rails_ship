module Ship
  class BoxProxySellsController < BaseController
    before_action :set_box_host

    def index
      @box_proxy_sells = @box_host.box_proxy_sells
    end

    private
    def set_box_host
      @box_host = BoxHost.find params[:box_host]
    end

  end
end
