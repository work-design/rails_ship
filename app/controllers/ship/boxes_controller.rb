module Ship
  class BoxesController < BaseController
    before_action :set_box, only: [:qrcode, :in_edit, :in_update]
    before_action :require_login

    def qrcode
      if current_user.organ_ids.include?(@box.organ_id)
        redirect_to({ controller: 'ship/me/boxes', action: 'qrcode', id: params[:id], host: @box.organ.host }, allow_other_host: true)
      else
        redirect_to({ controller: 'ship/boxes', action: 'in_edit', id: params[:id] }, allow_other_host: true)
      end
    end

    def in_edit
    end

    def in_update
      @box.organ_id = params[:organ_id]
      @box.save
    end

    private
    def set_box
      @box = Box.find params[:id]
    end

  end
end
