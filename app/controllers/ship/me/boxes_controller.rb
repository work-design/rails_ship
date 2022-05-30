module Ship
  class Me::BoxesController < Me::BaseController
    before_action :set_box, only: [:qrcode, :in, :out]
    before_action :set_package_from_scan, only: [:in, :out]

    def index
      q_params = {}
      q_params.merge! default_params

      @boxes = Box.default_where(q_params).page(params[:page])
    end

    def in
      if @package
        @package.box_id = @box.id
        @package.state = 'box_in'
        @package.boxed_in_at = Time.current
        @package.save
      end
    end

    def out
      if @package
        @package.box_id = @box.id
        @package.state = 'box_out'
        @package.boxed_out_at = Time.current
        @package.save
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

  end
end
