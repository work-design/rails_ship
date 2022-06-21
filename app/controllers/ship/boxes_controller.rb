module Ship
  class BoxesController < BaseController
    before_action :set_box, only: [:qrcode]

    def qrcode
      redirect_to controller: 'ship/me/boxes', action: 'qrcode', id: params[:id], host: @box.organ.host
    end

    private
    def set_box
      @box = Box.find params[:id]
    end

  end
end
