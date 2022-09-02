module Ship
  class BoxSellsController < BaseController
    before_action :set_box_host

    def index
      @box_sells = @box_host.box_sells.order(price: :asc)
    end

    private
    def set_box_host
      @box_host = BoxHost.find params[:box_host_id]
    end
  end
end
