module Ship
  class Admin::PaymentOrdersController < Admin::BaseController
    before_action :set_shipment
    before_action :set_station, only: [:station]
    before_action :set_payment_order, only: [:show, :edit, :update, :destroy, :actions, :payment_new, :payment_create]
    before_action :set_new_payment, only: [:payment_new, :payment_create]

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

    def payment_new
      @payment.total_amount = @payment_order.check_amount
    end

    def payment_create
      @payment_order.state = 'pending'
      @payment.save
    end

    private
    def set_shipment
      @shipment = Shipment.find params[:shipment_id]
    end

    def set_station
      @station = Station.find params[:station_id]
    end

    def set_payment_order
      @payment_order = @shipment.payment_orders.find params[:id]
    end

    def set_new_payment
      @payment = @payment_order.build_payment(payment_params)
    end

    def payment_params
      params.fetch(:payment, {}).permit(
        :type,
        :wallet_id,
        :total_amount,
        :proof
      )
    end

  end
end
