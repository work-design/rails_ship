module Ship
  class Share::OrdersController < Trade::My::OrdersController

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

  end
end

