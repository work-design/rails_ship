module Ship
  class Agent::AddressesController < Ship::Admin::AddressesController
    before_action :set_cart
    before_action :set_address, only: [:show, :edit, :update, :destroy, :actions]
    before_action :set_new_address, only: [:new, :create]
    before_action :set_stations, only: [:station]

    def index
      q_params = {}
      q_params.merge! params.permit(:station_id)

      @addresses = current_member.agent_addresses.includes(:area).default_where(q_params).page(params[:page])
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
        @address.save!
        @cart.save!
      end
    end

    def station
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
      @cart = current_member.agent_carts.find params[:cart_id]
    end

    def set_new_address
      @address = current_user.addresses.build(address_params)
    end

    def set_address
      @address = Profiled::Address.find(params[:id])
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
