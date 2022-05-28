module Ship
  class Share::BoxesController < Share::BaseController

    def index
      @boxes = Box.includes(:box_specification).page(params[:page])
    end

  end
end
