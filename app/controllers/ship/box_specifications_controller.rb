module Ship
  class BoxSpecificationsController < BaseController
    before_action :set_box_specification, only: [:show, :update]


    def index
      q_params = {}
      q_params.merge! default_params

      @box_specifications = BoxSpecification.page(params[:page])
    end

    def update
      @order = current_user.orders.build(order_params)
      @trade_item = @order.items[0]
      @trade_item.valid?
      @trade_item.compute
    end

    private
    def set_box_specification
      @box_specification = BoxSpecification.find params[:id]
    end



  end
end
