module Ship
  class Me::PackagesController < Me::BaseController
    before_action :set_package, only: [:qrcode, :in, :out, :loaded, :unloaded]
    before_action :set_box_from_scan, only: [:in, :out]
    before_action :set_shipment_from_scan, only: [:loaded, :unloaded]

    def index
      q_params = {}
      q_params.merge! params.permit(:address_id)

      @packages = Package.includes(:packageds, :address).default_where(q_params).page(params[:page])
    end

    # 入物流箱
    def in
      if @box
        bl = @box.box_logs.find_or_initialize_by(package_id: @package.id)
        bl.confirm_mode = 'scan'
        bl.boxed_in_at = Time.current
        bl.save
      end
    end

    # 出物流箱
    def out
      if @box
        @package.box == @box # todo 测试是否一致
        @package.confirm_mode = 'scan'
      else
        @package.confirm_mode = 'button'
      end

      @package.boxed_out_at = Time.current
      @package.last_box_id = @package.box_id
      @package.box_id = nil
      @package.state = 'box_out'
      @package.save
    end

    # 直接装车
    def loaded
      if @shipment
        si = @shipment.shipment_items.find_or_initialize_by(package_id: @package.id)
        si.state = 'loaded'
        si.loaded_at = Time.current
        si.confirm_mode = 'scan'
        si.save
      end
    end

    # 卸车
    def unloaded
      if @shipment
        si = @shipment.shipment_items.find_by(package_id: @package.id)
        si.state = 'unloaded'
        si.unloaded_at = Time.current
        si.confirm_mode = 'scan'
        si.save
      elsif params[:shipment_item_id]
        si = @package.shipment_items.find params[:shipment_item_id]
        si.state = 'unloaded'
        si.unloaded_at = Time.current
        si.confirm_mode = 'button'
        si.save
      end
    end

    def qrcode
    end

    private
    def set_package
      @package = Package.find(params[:id])
    end

    def set_box_from_scan
      return unless params[:result].present?
      r = params[:result].scan(RegexpUtil.more_between('boxes/', '/qrcode'))
      if r.present?
        @box = Box.find r[0]
      end
    end

    def set_shipment_from_scan
      return unless params[:result].present?
      r = params[:result].scan(RegexpUtil.more_between('shipments/', '/qrcode'))
      if r.present?
        @shipment = Shipment.find r[0]
      end
    end

    def package_params
      params.fetch(:package, {}).permit(
        :state,
        :expected_on
      )
    end

  end
end
