module Ship
  class My::OrdersController < My::BaseController
    before_action :set_box_hold
    before_action :set_new_order, only: [:create]

    private
    def set_box_hold
      @box_hold = BoxHold.find params[:box_hold_id]
    end

    def set_new_order
      @order = current_user.orders.build(order_params)
      @order.items.each do |item|
        @box_proxy_sell = @box_hold.box_host.box_proxy_sells.find_or_create_by(price: item.single_price)
        item.good = @box_proxy_sell
      end
      binding.b
    end

    def order_params
      params.fetch(:order, {}).permit(
        items_attributes: {}
      )
    end
  end
end
