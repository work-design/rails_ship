module Ship
  class BoxHoldsController < BaseController
    before_action :set_box_host

    def index
      @box_holds = @box_host.box_holds
    end

    private
    def set_box_host
      @box_host = BoxHost.find params[:box_host_id]
    end
  end
end
