module Ship
  class Share::BoxesController < Share::BaseController

    def index
      q_params = {}
      q_params.merge! params.permit(:box_specification_id)

      @boxes = Box.includes(:box_specification).default_where(q_params).page(params[:page])
    end

  end
end
