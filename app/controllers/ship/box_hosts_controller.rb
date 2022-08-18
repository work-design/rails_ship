module Ship
  class BoxHostsController < BaseController
    before_action :set_box_host, only: [:show, :boxes, :rentable, :rented]

    def index
      q_params = {}
      q_params.merge! default_params

      @box_hosts = BoxHost.page(params[:page])
    end

    def boxes
      @boxes = @box_host.boxes.page(params[:page])
    end

    def rentable
      @boxes = @box_host.boxes.rentable.page(params[:page])
    end

    def rented
      @boxes = @box_host.boxes.rented.page(params[:page])
    end

    private
    def set_box_host
      @box_host = BoxHost.find params[:id]
    end

  end
end
