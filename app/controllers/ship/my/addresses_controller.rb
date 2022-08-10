module Ship
  class My::AddressesController < My::BaseController
    before_action :set_address, only: [:show, :edit, :update, :destroy, :actions]
    before_action :set_new_address, only: [:new, :create, :order_new, :order_create]
    before_action :set_cart, only: [:cart, :new, :create]

    def index
      q_params = {}
      q_params.merge! params.permit(:station_id)

      @addresses = current_user.addresses.includes(:area).default_where(q_params).page(params[:page])
    end

    def cart
      q_params = {}

      @addresses = current_user.addresses.includes(:area).default_where(q_params).page(params[:page])
    end

    def order
      @addresses = current_user.addresses.includes(:area).page(params[:page])
    end

    def new
      @address = current_user.addresses.build(station_id: params[:station_id])
      @address.area = Profiled::Area.new
      @address.contact = current_user.name
      @address.tel = current_account.identity if current_account.is_a?(Auth::MobileAccount)
    end

    def create
      @cart.address = @address
      @address.class.transaction do
        @address.save
        @cart.save
      end
    end

    def order_create
      @address.save
    end

    private
    def set_stations
      @stations = Station.default_where(default_params)
    end

    def set_station
      @station = Station.find params[:station_id]
    end

    def set_not_stations
      @stations = Station.default_where(default_params).where.not(id: @station&.id)
    end

    def set_cart
      @cart = Trade::Cart.find params[:cart_id] if params[:cart_id]
    end

    def set_new_address
      @address = current_user.addresses.build(address_params)
    end

    def set_address
      @address = Profiled::Address.find(params[:id])
    end

    def _prefixes
      super do |pres|
        if ['new'].include?(params[:action])
          pres + ['profiled/my/addresses']
        else
          pres
        end
      end
    end

    def address_params
      params.fetch(:address, {}).permit(
        :station_id,
        :area_id,
        :contact,
        :tel,
        :detail,
        :floor,
        :room
      )
    end

  end
end
