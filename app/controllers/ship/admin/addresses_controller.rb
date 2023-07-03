module Ship
  class Admin::AddressesController < Admin::BaseController
    before_action :set_address, only: [:show, :edit, :update, :destroy, :actions]

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:user_id)

      @addresses = Trade::Item.packable.includes(:address).default_where(q_params).group_by(&:address)
    end

    def search
      q_params = {}
      q_params.merge! params.permit('name-like')

      @stations = Station.default_where(q_params)
    end

    def from
      q_params = {}
      q_params.merge! default_params

      r = Trade::Item.packable.default_where(q_params).select(:from_address_id).page(params[:page]).group(:from_address_id).count
      @addresses = Profiled::Address.find(r.keys).zip r.values
    end

    def packaged
      trade_q_params = {}
      trade_q_params.merge! default_params

      r = Trade::Item.packaged.default_where(trade_q_params).select(:address_id).page(params[:page]).group(:address_id).count
      @addresses = Profiled::Address.find(r.keys).zip r.values
    end

    private
    def set_address
      @address = Profiled::Address.find(params[:id])
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
