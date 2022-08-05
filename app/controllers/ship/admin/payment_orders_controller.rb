module Ship
  class Admin::PaymentOrdersController < Admin::BaseController
    before_action :set_shipment
    before_action :set_station, only: [:station]

    def index
      @payment_orders = @shipment.payment_orders.page(params[:page])
    end

    def station
      @shipment_log = @shipment.shipment_logs.find_by(station_id: params[:station_id])

      if @shipment_log
         @payment_orders = @shipment_log.payment_orders.page(params[:page])
      else
        @payment_orders = @shipment.payment_orders.page(params[:page])
      end

      render 'index'
    end

    private
    def set_shipment
      @shipment = Shipment.find params[:shipment_id]
    end

    def set_station
      @station = Station.find params[:station_id]
    end

  end
end
