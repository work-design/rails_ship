module Ship
  class Me::PackagesController < Me::BaseController
    before_action :set_package, only: [:show, :qrcode, :in, :out, :edit, :update, :destroy]
    before_action :set_box_from_scan, only: [:in, :out]

    def index
      q_params = {}
      q_params.merge! params.permit(:address_id)

      @packages = Package.includes(:packageds, :address).default_where(q_params).page(params[:page])
    end

    def in
      r = params[:result].scan(RegexpUtil.more_between('boxes/', '/qrcode'))
      if r
        @package.box_id = r[0]
        @package.state = 'box_in'
        @package.save
      end
    end

    def out
      r = params[:result].scan(RegexpUtil.more_between('boxes/', '/qrcode'))
      if r
        @package.box_id = r[0]
        @package.state = 'box_out'
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
      r = params[:result].scan(RegexpUtil.more_between('boxes/', '/qrcode'))
      if r.present?
        @package = Package.find r[0]
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
