class Ship::Admin::TradeItemsController < Ship::Admin::BaseController
  before_action :set_address
  before_action :set_trade_item, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {
      status: 'paid'
    }
    @trade_items = @address.trade_items.default_where(q_params).page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
    @trade_item.assign_attributes(trade_item_params)

    unless @trade_item.save
      render :edit, locals: { model: @trade_item }, status: :unprocessable_entity
    end
  end

  def destroy
    @trade_item.destroy
  end

  private
  def set_address
    @address = Address.find params[:address_id]
  end

  def set_trade_item
    @trade_item = TradeItem.find(params[:id])
  end

  def trade_item_params
    params.fetch(:trade_item, {}).permit(
      :good_id,
      :number,
      :status
    )
  end

end
