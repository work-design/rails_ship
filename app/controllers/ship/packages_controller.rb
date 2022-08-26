module Ship
  class PackagesController < BaseController
    before_action :require_login
    before_action :set_package, only: [:qrcode]

    def qrcode
      if current_account.members.exists?(organ_id: @package.organ_id)
        redirect_to({ controller: 'ship/me/packages', action: 'qrcode', id: params[:id], host: @package.organ.host }, allow_other_host: true)
      elsif current_user && @package.user == current_user
        redirect_to({ controller: 'ship/my/packages', action: 'qrcode', id: params[:id], host: @package.organ.host }, allow_other_host: true)
      else
        render 'qrcode'
      end
    end

    private
    def set_package
      @package = Package.find params[:id]
    end

  end
end
