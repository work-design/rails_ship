module Ship
  class Me::ShipmentsController < Me::BaseController
    before_action :set_shipment, only: [:show, :qrcode, :loaded, :unloaded, :edit, :update, :destroy]
    before_action :set_shipment_from_scan, only: [:box_in, :box_out]
    before_action :set_item_from_scan, only: [:loaded, :unloaded]

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

    def loaded
      if @item
        si = @shipment.shipment_items.find_or_initialize_by(item_type: @item.class_name, item_id: @item.id)
        si.state = 'loaded'
        si.loaded_at = Time.current
        si.save
      end
    end

    def unloaded
      if @item
        si = @shipment.shipment_items.find_or_initialize_by(item_type: @item.class_name, item_id: @item.id)
        si.state = 'unloaded'
        si.unloaded_at = Time.current
        si.save
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

    def set_item_from_scan
      p = params[:result].scan(RegexpUtil.more_between('packages/', '/qrcode'))
      if p.present?
        @item = Package.find p[0]
      end
      b = params[:result].scan(RegexpUtil.more_between('boxes/', '/qrcode'))
      if b.present?
        @item = Box.find b[0]
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
