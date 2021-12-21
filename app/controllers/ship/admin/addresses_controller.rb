module Ship
  class Admin::AddressesController < Admin::BaseController
    before_action :set_address, only: [:show, :edit, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! params.permit('address_users.user_id')

      @addresses = Address.default_where(q_params).page(params[:page])
    end

    private
    def set_address
      @address = Address.find(params[:id])
    end

    def address_params
      params.fetch(:address, {}).permit! #(:user_id, :buyer_id, :area_id, :kind, :contact_person, :tel, :address)
    end

  end
end
