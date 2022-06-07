module Ship
  class Share::BoxesController < Share::BaseController
    before_action :set_box_specifications, only: [:index]

    def index
      q_params = {}
      q_params.merge! params.permit(:box_specification_id)

      @boxes = Box.includes(:box_specification).default_where(q_params).page(params[:page])
    end

    private
    def set_box_specifications
      @box_specifications = BoxSpecification.all
    end

  end
end
