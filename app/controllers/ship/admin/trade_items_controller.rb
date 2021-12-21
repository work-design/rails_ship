module Ship
  class Admin::TradeItemsController < Admin::BaseController
    before_action :set_address
    before_action :set_trade_item, only: [:show, :edit, :update, :destroy]

    def index
      q_params = {
        status: 'paid'
      }
      @trade_items = @address.trade_items.includes(:trade, :produce_plan).default_where(q_params).page(params[:page])
    end

    def package
      pack = @address.packages.build
      trade_items = @address.trade_items.paid.find params[:add_ids].split(',')
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

      render 'create'
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
end
