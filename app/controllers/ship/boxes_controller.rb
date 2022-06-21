module Ship
  class BoxesController < BaseController

    def qrcode
      url = url_for(controller: 'ship/me/boxes', action: 'qrcode', id: params[:id], host: @box.organ.host)
      render 'qrcode', locals: { url: url }, layout: 'raw'
    end

    private
    def set_box
      @box = Box.find params[:id]
    end

  end
end
