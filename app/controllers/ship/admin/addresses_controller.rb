module Ship
  class Admin::AddressesController < Admin::BaseController
    before_action :set_address, only: [:show, :edit, :update, :destroy, :actions]

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:user_id)

      @addresses = Trade::Item.packable.includes(:address).default_where(q_params).page(params[:page]).group_by(&:address)
      @addresses.delete(nil)
    end

    def search
      q_params = {}
      q_params.merge! params.permit('name-like')

      @stations = Station.default_where(q_params)
    end

    def from
      q_params = {}
      q_params.merge! default_params

      @addresses = Trade::Item.packable.includes(:from_address).default_where(q_params).page(params[:page]).group_by(&:from_address)
      @addresses.delete(nil)
    end

    def packaged
      q_params = {}
      q_params.merge! default_params

      @addresses = Trade::Item.packaged.includes(:from_address).default_where(q_params).page(params[:page]).group_by(&:from_address)
      @addresses.delete(nil)
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
