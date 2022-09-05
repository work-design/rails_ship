module Ship
  class BoxProxyBuysController < BaseController
    before_action :set_box_host

    def index
      @box_proxy_buys = @box_host.box_proxy_buys.order(price: :desc)
    end

    private
    def set_box_host
      @box_host = BoxHost.find params[:box_host_id]
    end
  end
end
