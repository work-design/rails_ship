module Ship
  class Me::ShipmentsController < Me::BaseController
    before_action :set_shipment, only: [:show, :qrcode, :edit, :update, :destroy]
    before_action :set_shipment_from_scan, only: [:box_in, :box_out]

    def index
      q_params = {}
      q_params.merge! params.permit(:address_id)

      @shipments = Shipment.includes(:shipmentds, :address).default_where(q_params).page(params[:page])
    end

    def box_in
      if @shipment
        @shipment.assign_attributes params.permit(:box_id)
        @shipment.state = 'box_in'
        @shipment.save
      end
    end

    def box_out
      if @shipment
        @shipment.assign_attributes params.permit(:box_id)
        @shipment.state = 'box_out'
        @shipment.save
      end
    end

    def qrcode
    end

    private
    def set_shipment
      @shipment = Shipment.find(params[:id])
    end

    def set_shipment_from_scan
      r = params[:result].scan(RegexpUtil.more_between('shipments/', '/qrcode'))
      if r.present?
        @shipment = Shipment.find r[0]
      end
    end

    def shipment_params
      params.fetch(:shipment, {}).permit(
        :state,
        :expected_on
      )
    end

  end
end
