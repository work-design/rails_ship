module Ship
  class BoxSpecificationsController < BaseController
    before_action :set_box_specification, only: [:show, :update]
    before_action :set_use_cart, only: [:index]
    before_action :set_rent_cart, only: [:rent]
    before_action :set_cart, only: [:show]

    def index
      @box_specifications = BoxSpecification.page(params[:page])
    end

    def rent
      @box_specifications = BoxSpecification.page(params[:page])
    end

    def show
      @order = current_user.orders.build(order_params)
      @trade_item = @order.trade_items.build
    end

    def update
      @order = current_user.orders.build(order_params)
      @trade_item = @order.trade_items[0]
      @trade_item.valid?
      @trade_item.compute
    end

    private
    def set_box_specification
      @box_specification = BoxSpecification.find params[:id]
    end

    def set_cart
      @cart = current_carts.find_or_create_by(good_type: 'Ship::BoxSpecification', aim: nil)
    end

    def set_use_cart
      @cart = current_carts.find_or_create_by(good_type: 'Ship::BoxSpecification', aim: 'use')
    end

    def set_rent_cart
      @cart = current_carts.find_or_create_by(good_type: 'Ship::BoxSpecification', aim: 'rent')
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
