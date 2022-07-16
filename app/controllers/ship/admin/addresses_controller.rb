module Ship
  class Admin::AddressesController < Admin::BaseController
    before_action :set_address, only: [:show, :edit, :update, :destroy, :actions]
    before_action :set_stations, only: [:edit, :update]

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:user_id)

      r = Trade::TradeItem.packable.default_where(q_params).select(:address_id).page(params[:page]).group(:address_id).count
      @addresses = Profiled::Address.find(r.keys).zip r.values
    end

    def from
      q_params = {}
      q_params.merge! default_params

      r = Trade::TradeItem.packable.default_where(q_params).select(:from_address_id).page(params[:page]).group(:from_address_id).count
      @addresses = Profiled::Address.find(r.keys).zip r.values
    end

    def packaged
      trade_q_params = {}
      trade_q_params.merge! default_params

      r = Trade::TradeItem.packaged.default_where(trade_q_params).select(:address_id).page(params[:page]).group(:address_id).count
      @addresses = Profiled::Address.find(r.keys).zip r.values
    end

    private
    def set_address
      @address = Profiled::Address.find(params[:id])
    end

    def set_stations
      @stations = Station.default_where(default_params)
    end

    def address_params
      params.fetch(:address, {}).permit(
        :area_id,
        :station_id,
        :contact,
        :tel,
        :detail
      )
    end

  end
end
