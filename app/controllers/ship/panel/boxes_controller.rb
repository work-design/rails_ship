module Ship
  class Panel::BoxesController < Panel::BaseController
    before_action :set_box_specification
    before_action :set_box, only: [:show, :edit, :update, :destroy, :actions]

    def index
      @boxes = @box_specification.boxes.page(params[:page])
    end

    private
    def set_box_specification
      @box_specification = BoxSpecification.find params[:box_specification_id]
    end

    def set_box
      @box = @box_specification.boxes.find params[:id]
    end

  end
end
