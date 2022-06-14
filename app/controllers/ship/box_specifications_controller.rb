module Ship
  class BoxSpecificationsController < BaseController
    before_action :set_box_specification, only: [:show]

    def index
      @box_specifications = BoxSpecification.page(params[:page])
    end

    def rent
      @box_specifications = BoxSpecification.page(params[:page])
    end

    private
    def set_box_specification
      @box_specification = BoxSpecification.find params[:id]
    end

  end
end
