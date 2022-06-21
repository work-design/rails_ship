module Ship
  class ShipmentsController < BaseController
    before_action :set_shipment, only: [:qrcode]

    def qrcode
      redirect_to({ controller: 'ship/me/shipments', action: 'qrcode', id: params[:id], host: @shipment.organ.host }, allow_other_host: true)
    end

    private
    def set_shipment
      @shipment = Shipment.find params[:id]
    end

  end
end
