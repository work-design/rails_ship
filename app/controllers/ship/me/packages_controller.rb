module Ship
  class Me::PackagesController < Me::BaseController
    before_action :set_package, only: [:show, :qrcode, :edit, :update, :destroy]
    before_action :set_package_from_scan, only: [:box_in, :box_out]

    def index
      q_params = {}
      q_params.merge! params.permit(:address_id)

      @packages = Package.includes(:packageds, :address).default_where(q_params).page(params[:page])
    end

    def box_in
      if @package
        @package.assign_attributes params.permit(:box_id)
        @package.state = 'box_in'
        @package.save
      end
    end

    def box_out
      if @package
        @package.assign_attributes params.permit(:box_id)
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

    def set_package_from_scan
      r = params[:result].scan(RegexpUtil.more_between('packages/', '/qrcode'))
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
