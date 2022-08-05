module Ship
  class Admin::ShipmentLogsController < Admin::BaseController
    before_action :set_shipment

    def index
      @shipment_logs = @shipment.shipment_logs.includes(line_station: [:line, :station])
    end

    private
    def set_shipment
      @shipment = Shipment.find params[:shipment_id]
    end

  end
end
