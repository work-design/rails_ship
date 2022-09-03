module Ship
  class BoxSellsController < BaseController
    before_action :set_box_host
    before_action :set_overview, only: [:index, :sell]

    def index
      q_options = { box_specification_id: @box_host.box_specification_id }
      q_options.merge! default_params

      @box_hold = current_user.box_holds.find_or_initialize_by(q_options)
    end

    def sell
      q_options = { box_specification_id: @box_host.box_specification_id }
      q_options.merge! default_params

      @box_hold = current_user.box_holds.find_or_initialize_by(q_options)
    end

    private
    def set_box_host
      @box_host = BoxHost.find params[:box_host_id]
    end

    def set_overview
      @box_sells = @box_host.box_sells.order(price: :asc).limit(3)
      @box_buys = @box_host.box_buys.order(price: :desc).limit(3)
    end

  end
end
