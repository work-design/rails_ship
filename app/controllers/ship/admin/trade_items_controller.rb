module Ship
  class Admin::TradeItemsController < Admin::BaseController
    before_action :set_address, only: [:package]
    before_action :set_trade_item, only: [:show, :edit, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! params.permit(:user_id, :address_id)

      @trade_items = Trade::TradeItem.includes(:produce_plan, :address, :order).deliverable.where.not(address_id: nil).default_where(q_params).page(params[:page])
    end

    def package
      pack = @address.packages.build
      trade_items = @address.trade_items.deliverable.find params[:ids].split(',')
      user_ids = trade_items.pluck(:user_id).uniq
      if user_ids.size > 1
        render 'edit', locals: { message: 'user 不一致，不能打包' } and return
      end
      produce_plan_ids = trade_items.pluck(:produce_plan_id).uniq
      if produce_plan_ids.size > 1
        render 'edit', locals: { message: 'produce plan 不一致，不能打包' } and return
      end

      pack.user_id = user_ids[0]
      pack.produce_plan_id = produce_plan_ids[0]
      trade_items.each do |trade_item|
        p = trade_item.packageds.build
        p.package = pack
        p.save
      end
    end

    private
    def set_address
      @address = Profiled::Address.find params[:address_id]
    end

    def set_trade_item
      @trade_item = Trade::TradeItem.find(params[:id])
    end

    def trade_item_params
      params.fetch(:trade_item, {}).permit(
        :good_id,
        :number,
        :status
      )
    end

  end
end
