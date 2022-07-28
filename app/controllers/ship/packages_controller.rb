module Ship
  class PackagesController < BaseController
    before_action :require_login
    before_action :set_package, :set_member, only: [:qrcode]

    def qrcode
      if @member
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

    def set_member
      @member = current_account.members.find_by(organ_id: @package.organ_id)
    end

  end
end
