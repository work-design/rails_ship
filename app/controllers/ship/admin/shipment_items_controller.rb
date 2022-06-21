module Ship
  class Admin::ShipmentItemsController < Admin::BaseController
    before_action :set_shipment

    def index
      @shipment_items = @shipment.shipment_items.order(id: :desc).page(params[:id])
    end

    private
    def set_shipment
      @shipment = Shipment.find params[:shipment_id]
    end
  end
end
