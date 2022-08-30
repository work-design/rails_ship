module Ship
  class Admin::ItemsController < Admin::BaseController
    before_action :set_address, only: [:packable, :package, :packaged]
    before_action :set_item, only: [:show, :edit, :update, :destroy]
    before_action :set_stations, only: [:edit, :update]
    before_action :set_user, only: [:user]

    def index
      q_params = {
        status: ['paid', 'packaged']
      }
      q_params.merge! default_params
      q_params.merge! params.permit(:user_id, :address_id, :status)

      @items = Trade::Item.includes(:produce_plan, :order, :user, :station, :from_station, address: :area, from_address: :area).default_where(q_params).order(id: :desc).page(params[:page])
    end

    def box

    end

    def packable
      @items = @address.items.includes(:produce_plan).packable.order(id: :asc).page(params[:page])
      @produce_plans = @items.map(&:produce_plan).compact.uniq
    end

    def packaged
      @items = @address.items.packaged.order(id: :desc).page(params[:page])
    end

    def user
      @items = @user.items.includes(:produce_plan).packable.order(id: :asc).page(params[:page])
      @produce_plans = @items.map(&:produce_plan).compact.uniq
    end

    private
    def set_item
      @item = Trade::Item.find(params[:id])
    end

    def set_address
      @address = Profiled::Address.find params[:address_id]
    end

    def set_user
      @user = Auth::User.find params[:user_id]
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
