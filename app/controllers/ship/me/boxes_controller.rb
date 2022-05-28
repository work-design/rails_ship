module Ship
  class Me::BoxesController < Me::BaseController
    before_action :set_box, only: [:qrcode]
    before_action :set_box_from_scan, only: [:package_in, :package_out]
    before_action :set_package, only: [:package_in, :package_out]

    def index
      q_params = {}
      q_params.merge! default_params

      @boxes = Box.default_where(q_params).page(params[:page])
    end

    def package_in
      if @box && @package
        @package.box_id = @box.id
        @package.state = 'box_in'
        @package.save
      end
    end

    def package_out
      if @box && @package
        @package.box_id = @box.id
        @package.state = 'box_out'
        @package.save
      end
    end

    def qrcode
    end

    private
    def set_package
      @package = Package.find params[:package_id]
    end

    def set_box
      @box = Box.default_where(default_params).find params[:id]
    end

    def set_box_from_scan
      r = params[:result].scan(RegexpUtil.more_between('boxes/', '/qrcode'))
      if r.present?
        @box = Box.find r[0]
      end
    end

  end
end
