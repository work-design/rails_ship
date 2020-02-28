class Ship::Admin::AddressesController < Ship::Admin::BaseController
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! params.permit('address_users.user_id')

    @addresses = Address.includes(:area).default_where(q_params).page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to admin_addresses_url(user_id: @address.user_id), notice: 'Address was successfully updated.' }
        format.js
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to admin_addresses_url(user_id: @address.user_id), notice: 'Address was successfully destroyed.' }
      format.js
    end
  end

  private
  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    params.fetch(:address, {}).permit! #(:user_id, :buyer_id, :area_id, :kind, :contact_person, :tel, :address)
  end

end
