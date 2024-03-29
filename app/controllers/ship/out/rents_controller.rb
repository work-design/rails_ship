module Ship
  class Out::RentsController < Out::BaseController
    before_action :set_box

    def index
      @rents = @box.rents.page(params[:page])
    end

    private
    def set_box
      @box = Box.find params[:box_id]
    end

  end
end
