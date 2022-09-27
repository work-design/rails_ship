module Ship
  class My::BoxEntrustsController < My::BaseController
    before_action :set_box_host
    before_action :set_overview, only: [:index, :sell]
    before_action :set_new_box_buy, only: [:index]
    before_action :set_new_box_sell, only: [:sell]
    before_action :set_lawful_wallet, only: [:index]

    def index
      q_options = { box_specification_id: @box_host.box_specification_id }
      q_options.merge! default_params
    end

    def sell
      q_options = { box_specification_id: @box_host.box_specification_id }
      q_options.merge! default_params
    end

    private
    def set_box_host
      @box_host = BoxHost.find params[:box_host_id]
      @box_hold = @box_host.box_holds.find_or_create_by(user_id: current_user.id)
    end

    def set_new_box_sell
      @box_sell = @box_hold.box_sells.build
      @box_sell.price = @box_proxy_buys.maximum(:price) || @box_host.price
      @box_sell.amount = [10, @box_hold.boxes_count].min
    end

    def set_new_box_buy
      @order = current_user.orders.build
      price = @box_proxy_sells.minimum(:price) || @box_host.price
      @order.items.build(single_price: price)
    end

    def set_overview
      x1 = @box_host.box_proxy_sells.default_where('sellable_count-gt': 0).order(price: :asc).limit(3)
      x2 = @box_host.box_proxy_sells.where.not(id: x1.pluck(:id)).order(price: :asc).limit(3 - x1.size)
      @box_proxy_sells = x1 + x2

      y1 = @box_host.box_proxy_buys.default_where('buyable_count-gt': 0).order(price: :desc).limit(3)
      y2 = @box_host.box_proxy_buys.where.not(id: y1.pluck(:id)).order(price: :desc).limit(3 - y1.size)
      @box_proxy_buys = y1 + y2

      @items = @box_host.items.where(user_id: @box_hold.user_id).order(id: :desc).limit(7)
      @box_sells = @box_hold.box_sells.order(id: :desc).limit(7)
    end

  end
end
