module Ship
  class Me::BoxesController < Me::BaseController
    before_action :set_box, only: [:qrcode, :in, :out, :loaded, :unloaded]
    before_action :set_package_from_scan, only: [:in, :out]
    before_action :set_shipment_from_scan, only: [:loaded, :unloaded]

    def index
      q_params = {}
      q_params.merge! default_params

      @boxes = Box.default_where(q_params).page(params[:page])
    end

    # 装入包裹
    def in
      if @package
        @package.box = @box
        @package.state = 'box_in'
        @package.boxed_in_at = Time.current
        @package.save
      end
    end

    # 取出包裹
    def out
      if @package
        @package.box = @box
        @package.state = 'box_out'
        @package.boxed_out_at = Time.current
        @package.save
      end
    end

    # 装车
    def loaded
      if @shipment
        @box.assign_attributes params.permit(:box_id)
        @box.state = 'loaded'
        @box.save
      end
    end

    # 卸车
    def unloaded
      if @shipment
        @box.assign_attributes params.permit(:box_id)
        @box.state = 'unloaded'
        @box.save
      end
    end

    def qrcode
    end

    private
    def set_box
      @box = Box.default_where(default_params).find params[:id]
    end

    def set_package_from_scan
      r = params[:result].scan(RegexpUtil.more_between('packages/', '/qrcode'))
      if r.present?
        @package = Package.find r[0]
      end
    end

    def set_shipment_from_scan
      r = params[:result].scan(RegexpUtil.more_between('shipments/', '/qrcode'))
      if r.present?
        @shipment = Shipment.find r[0]
      end
    end

  end
end
