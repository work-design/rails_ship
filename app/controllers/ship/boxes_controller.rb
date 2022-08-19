module Ship
  class BoxesController < BaseController
    before_action :require_login
    before_action :set_box, only: [:qrcode, :in_edit, :in_update]
    before_action :set_box_from_scan, only: [:in_create]
    before_action :set_new_order, only: [:in_edit]

    def qrcode
      if current_user.organ_ids.include?(@box.organ_id)
        redirect_to({ controller: 'ship/me/boxes', action: 'qrcode', id: params[:id], host: @box.organ.host }, allow_other_host: true)
      elsif current_user.organ_ids.present?
        redirect_to({ controller: 'ship/boxes', action: 'in_edit', id: params[:id] }, allow_other_host: true)
      else
        redirect_to({ controller: 'ship/my/boxes', action: 'qrcode', id: params[:id] }, allow_other_host: true)
      end
    end

    def in_create
      if @box
        @box.organ_id = params[:organ_id]
        @box.save
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

    def set_new_order
      @order = current_user.orders.build
      @order.items.build
    end

    def set_box_from_scan
      return unless params[:result].present?
      r = params[:result].scan(RegexpUtil.more_between('boxes/', '/qrcode'))
      if r.present?
        @box = Box.find r[0]
      end
    end

  end
end
