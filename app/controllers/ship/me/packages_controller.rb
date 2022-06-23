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
        @package.confirm_mode = 'scan'
        @package.boxed_in_at = Time.current
        @package.save
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
        @package.confirm_mode = 'scan'
        @package.state = 'loaded'
        @package.loaded_at = Time.current
      end
      @package.save
    end

    # 卸车
    def unloaded
      if @shipment
        @package.confirm_mode = 'scan'
      else
        @package.confirm_mode = 'button'
      end
      @package.unloaded_at = Time.current
      @package.state = 'unloaded'
      @package.save
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
