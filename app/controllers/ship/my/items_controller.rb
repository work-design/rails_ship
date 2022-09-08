module Ship
  class My::ItemsController < My::BaseController
    before_action :set_box_hold
    before_action :set_item, only: [:show]

    private
    def set_box_hold
      @box_hold = BoxHold.find params[:box_hold_id]
    end

    def set_item
      @item = @box_hold.box_host.items.find params[:id]
    end

  end
end
