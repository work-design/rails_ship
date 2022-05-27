module Ship
  class Admin::BoxesController < Admin::BaseController
    before_action :set_box_specification

    def index
      @boxes = @box_specification.boxes.page(params[:page])
    end

    private
    def set_box_specification
      @box_specification = BoxSpecification.find params[:box_specification_id]
    end

  end
end
