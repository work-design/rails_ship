module Ship
  class BoxesController < BaseController
    before_action :require_login, only: [:qrcode, :in_edit, :in_update, :in_create]
    before_action :set_box_host, only: [:index]
    before_action :set_box, only: [:qrcode, :in_edit, :in_update]
    before_action :set_box_from_scan, only: [:in_create]
    before_action :set_new_order, only: [:in_edit]

    def index
      @boxes = @box_host.boxes.page(params[:page])
    end

    def qrcode
      if current_user.organ_ids.all?(@box.organ_id)
        redirect_to({ controller: 'ship/me/boxes', action: 'qrcode', id: @box.id, host: @box.organ.host }, allow_other_host: true)
      elsif current_user.organ_ids.present?
        redirect_to({ controller: 'ship/boxes', action: 'in_edit', id: @box.code }, allow_other_host: true)
      else
        redirect_to({ controller: 'ship/my/boxes', action: 'qrcode', id: @box.id }, allow_other_host: true)
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
    def set_box_host
      @box_host = BoxHost.find params[:box_host_id]
    end

    def set_box
      @box = Box.find_by code: params[:id]
    end

    def set_new_order
      @order = current_user.orders.build
      @order.items.build
    end

    def set_box_from_scan
      return unless params[:result].present?
      r = params[:result].scan(RegexpUtil.more_between('boxes/', '/qrcode'))
      if r.present?
        @box = Box.find_by code: r[0]
      end
    end

  end
end
