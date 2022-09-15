module Ship
  class Admin::RentsController < Admin::BaseController
    before_action :set_box

    def index
      @rents = @box.rents.order(id: :desc).page(params[:page])
    end

    private
    def set_box
      @box = Box.find params[:box_id]
    end
  end
end
