module Ship
  class Me::ShipmentsController < Me::BaseController
    before_action :set_shipment, only: [:qrcode, :loaded, :unloaded]
    before_action :set_box_from_scan, :set_package_from_scan, only: [:loaded, :unloaded]

    def index
      q_params = {}
      q_params.merge! params.permit(:address_id)

      @shipments = Shipment.includes(:shipmentds, :address).default_where(q_params).page(params[:page])
    end

    def loaded
      if @box
        @box.packages.state_box_in.each do |package|
          si = @shipment.shipment_items.find_or_initialize_by(box_id: @box.id, package_id: package.id)
          si.state = 'loaded'
          si.loaded_at = Time.current
        end
      elsif @package
        si = @shipment.shipment_items.find_or_initialize_by(package_id: @package.id)
        si.state = 'loaded'
        si.loaded_at = Time.current
      end

      @shipment.save
    end

    def unloaded
      if @box
        @shipment.shipment_items.state_loaded.where(box_id: @box.id).each do |si|
          si.state = 'unloaded'
          si.unloaded_at = Time.current
          si.save
        end
      elsif @package
        si = @shipment.shipment_items.find_or_initialize_by(package_id: @package.id)
        si.state = 'unloaded'
        si.status = 'never_loaded' if si.new_record?
        si.unloaded_at = Time.current
      end

      @shipment.save
    end

    def qrcode
    end

    private
    def set_shipment
      @shipment = Shipment.find(params[:id])
    end

    def set_package_from_scan
      p = params[:result].scan(RegexpUtil.more_between('packages/', '/qrcode'))
      if p.present?
        @package = Package.find p[0]
      end
    end

    def set_box_from_scan
      b = params[:result].scan(RegexpUtil.more_between('boxes/', '/qrcode'))
      if b.present?
        @box = Box.find b[0]
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
