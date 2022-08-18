module Ship
  class Admin::BoxHostsController < Admin::BaseController

    def index
      @box_hosts = BoxHost.includes(:box_specification).page(params[:page])
    end

  end
end
