module Ship
  class My::AddressesController < My::BaseController
    before_action :set_address, only: [:show, :edit, :update, :destroy]

    def index
      @addresses = current_cart.addresses.includes(:area).page(params[:page])
    end

    def new
      @address = current_cart.addresses.build
    end

    def create
      @address = current_cart.addresses.build(address_params)

      if @address.save
        render 'create'
      else
        render :new, locals: { model: @address }, status: :unprocessable_entity
      end
    end

    private
    def set_address
      @address = Address.find(params[:id])
    end

    def address_params
      params.fetch(:address, {}).permit(
        :station_id,
        :contact_person,
        :tel,
        :address
      )
    end

  end
end
