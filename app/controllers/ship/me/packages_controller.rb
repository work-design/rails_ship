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
        @package.box = @box
        @package.state = 'box_in'
        @package.save
      end
    end

    # 出物流箱
    def out
      if @box
        @package.box = @box # 测试是否一致
        @package.state = 'box_out'
        @package.status = 'scan_out'
      else
        @package.state = 'box_out'
        @package.status = 'confirm_out'
      end

      @package.save
    end

    # 直接装车
    def loaded
      if @shipment
        @package.assign_attributes params.permit(:box_id)
        @package.state = 'loaded'
        @package.save
      end
    end

    # 卸车
    def unloaded
      if @shipment
        @package.assign_attributes params.permit(:box_id)
        @package.state = 'unloaded'
        @package.save
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
