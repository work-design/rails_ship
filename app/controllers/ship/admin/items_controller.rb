module Ship
  class Admin::ItemsController < Admin::BaseController
    before_action :set_address, only: [:packable, :package, :packaged]
    before_action :set_item, only: [:show, :edit, :update, :destroy]
    before_action :set_stations, only: [:edit, :update]

    def index
      q_params = {
        status: ['paid', 'packaged']
      }
      q_params.merge! default_params
      q_params.merge! params.permit(:user_id, :address_id, :status)

      @items = Trade::Item.includes(:produce_plan, :order, :user, :station, :from_station, address: :area, from_address: :area).where.not(address_id: nil).default_where(q_params).order(id: :desc).page(params[:page])
    end

    def packable
      @items = @address.items.packable.page(params[:page])
    end

    def packaged
      @items = @address.items.packaged.order(id: :desc).page(params[:page])
    end

    def package
      pack = @address.packages.build(default_form_params)
      items = @address.items.deliverable.find params[:ids].split(',')

      produce_plan_ids = items.pluck(:produce_plan_id).uniq
      if produce_plan_ids.size > 1
        render 'edit', locals: { message: 'produce plan 不一致，不能打包' } and return
      end

      pack.user_id = @address.user_id
      pack.produce_plan_id = produce_plan_ids[0]
      items.each do |item|
        p = item.packageds.build
        p.package = pack
        p.save
      end
    end

    private
    def set_address
      @address = Profiled::Address.find params[:address_id]
    end

    def set_item
      @item = Trade::Item.find(params[:id])
    end

    def set_stations
      @stations = Station.default_where(default_params)
    end

    def item_params
      params.fetch(:item, {}).permit(
        :from_station_id,
        :station_id
      )
    end

  end
end