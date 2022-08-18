module Ship
  class BoxHostsController < BaseController
    before_action :set_box_host, only: [:show, :update]

    def index
      q_params = {}
      q_params.merge! default_params

      @box_hosts = BoxHost.page(params[:page])
    end

    def rented
      @box_host.boxes.rented
    end

    private
    def set_box_host
      @box_host = BoxHost.find params[:id]
    end

  end
end
