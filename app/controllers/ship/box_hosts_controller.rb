module Ship
  class BoxHostsController < BaseController
    before_action :set_box_host, only: [:show, :all, :rentable, :rented]
    before_action :set_use_cart, only: [:index]
    before_action :set_rent_cart, only: [:rent]
    before_action :set_invest_cart, only: [:invest]
    before_action :set_cart, only: [:show]

    def index
      q_params = {}
      q_params.merge! default_params

      @box_hosts = BoxHost.includes(:box_specification).default_where(q_params).page(params[:page])
    end

    def overview
      q_params = {}
      q_params.merge! default_params

      @box_hosts = BoxHost.includes(:box_specification).default_where(q_params).page(params[:page])
    end

    def rent
      q_params = {}
      q_params.merge! default_params

      @box_hosts = BoxHost.includes(:box_specification).page(params[:page])
    end

    def invest
      q_params = {}
      q_params.merge! default_params

      @box_hosts = BoxHost.includes(:box_specification).page(params[:page])
    end

    def all
      @boxes = @box_host.boxes.page(params[:page])
    end

    def rentable
      @boxes = @box_host.boxes.tradable.page(params[:page])
    end

    def rented
      @boxes = @box_host.boxes.traded.page(params[:page])
    end

    def show
      @order = current_user.orders.build(order_params)
      @trade_item = @order.items.build
    end

    private
    def set_box_host
      @box_host = BoxHost.find params[:id]
    end

    def set_cart
      @cart = current_carts.find_or_create_by(good_type: 'Ship::BoxHost', aim: nil)
    end

    def set_use_cart
      @cart = current_carts.find_or_create_by(good_type: 'Ship::BoxHost', aim: 'use')
    end

    def set_rent_cart
      @cart = current_carts.find_or_create_by(good_type: 'Ship::BoxHost', aim: 'rent')
    end

    def set_invest_cart
      @cart = current_carts.find_or_create_by(good_type: 'Ship::BoxHost', aim: 'invest')
    end

    def order_params
      p = params.fetch(:order, {}).permit(
        :quantity,
        :payment_id,
        :payment_type,
        :address_id,
        :note,
        trade_items_attributes: {}
      )
      p.merge! default_form_params
    end

  end
end
