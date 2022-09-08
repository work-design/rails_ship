module Ship
  class My::BoxEntrustsController < My::BaseController
    before_action :set_box_host
    before_action :set_overview, only: [:index, :sell]
    before_action :set_new_box_buy, only: [:index]
    before_action :set_new_box_sell, only: [:sell]

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
      @box_hold = @box_host.box_holds.find_or_create_by(user_id: current_user.id)
    end

    def set_new_box_sell
      @box_sell = @box_hold.box_sells.build
    end

    def set_new_box_buy
      @order = current_user.orders.build
      @order.items.build
    end

    def set_overview
      @box_proxy_sells = @box_host.box_proxy_sells.order(price: :asc).limit(3)
      @box_proxy_buys = @box_host.box_proxy_buys.order(price: :desc).limit(3)
      @box_entrusts = @box_hold.box_sells.order(id: :desc).limit(5)
      @items = @box_host.items.where(user_id: @box_hold.user_id)
    end

  end
end
