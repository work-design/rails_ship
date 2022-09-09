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
      @order.pay_auto = true
      @order.items.each do |item|
        item.good = @box_hold.box_host
      end
    end

    def order_params
      p = params.fetch(:order, {}).permit(
        items_attributes: {}
      )
      p.merge! default_form_params
    end
  end
end
