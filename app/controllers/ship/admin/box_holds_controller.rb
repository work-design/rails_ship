module Ship
  class Admin::BoxHoldsController < Admin::BaseController
    before_action :set_box_host

    def index
      @box_holds = @box_host.box_holds.order(id: :desc).page(params[:page])
    end

    private
    def set_box_host
      @box_host = BoxHost.find params[:box_host_id]
    end
  end
end
