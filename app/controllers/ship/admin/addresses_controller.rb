module Ship
  class Admin::AddressesController < Admin::BaseController
    before_action :set_address, only: [:show, :edit, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:user_id)

      r = Trade::TradeItem.packable.default_where(q_params).select(:address_id).group(:address_id).count
      @addresses = Profiled::Address.find(r.keys).zip r.values
    end

    private
    def set_address
      @address = Profiled::Address.find(params[:id])
    end

    def address_params
      params.fetch(:address, {}).permit(
        :area_id,
        :state_id,
        :contact,
        :tel,
        :detail
      )
    end

  end
end
