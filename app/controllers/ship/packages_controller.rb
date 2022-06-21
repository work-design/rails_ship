module Ship
  class PackagesController < BaseController
    before_action :set_package, only: [:qrcode]

    def qrcode
      redirect_to({ controller: 'ship/me/packages', action: 'qrcode', id: params[:id], host: @package.organ.host }, allow_other_host: true)
    end

    private
    def set_package
      @package = Package.find params[:id]
    end

  end
end
