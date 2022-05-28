module Ship
  class Buy::OrdersController < Trade::Me::OrdersController
    include Controller::Buy
    before_action :set_order, only: [:show, :edit, :update, :payment_types, :edit_payment_type]

    def index
      q_params = {}
      q_params.merge! params.permit(:id, :payment_type, :payment_status, :state)

      @orders = current_organ.member_orders.includes(:trade_items).default_where(q_params).order(id: :desc).page(params[:page])
    end

    def create
      @order = current_member.orders.build
      @trade_items = Trade::TradeItem.where(id: params[:ids].split(','))
      @trade_items.each do |trade_item|
        trade_item.order = @order
        trade_item.status = 'ordered'
        trade_item.address_id = params[:address_id]
      end

      if @order.save
        render 'create'
      else
        render :new, locals: { model: current_organ }, status: :unprocessable_entity
      end
    end

    private
    def set_order
      @order = current_organ.member_orders.find params[:id]
    end

  end
end

