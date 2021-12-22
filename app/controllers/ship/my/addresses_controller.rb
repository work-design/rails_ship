module Ship
  class My::AddressesController < My::BaseController
    before_action :set_address, only: [:show, :edit, :update, :destroy]

    def index
      @addresses = current_user.addresses.includes(:area)
      station_ids = @addresses.pluck(:station_id)
      @stations = Station.default_where(default_params).where.not(id: station_ids)
    end

    def new
      @address = current_user.addresses.build(station_id: params[:station_id])
    end

    def create
      @address = current_user.addresses.build(address_params)

      if @address.save
        render 'create'
      else
        render :new, locals: { model: @address }, status: :unprocessable_entity
      end
    end

    private
    def set_stations
      @stations = Station.default_where(default_params)
    end

    def set_address
      @address = Profiled::Address.find(params[:id])
    end

    def address_params
      params.fetch(:address, {}).permit(
        :station_id,
        :contact,
        :tel,
        :floor,
        :room
      )
    end

  end
end
