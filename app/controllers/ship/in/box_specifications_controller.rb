module Ship
  class In::BoxSpecificationsController < In::BaseController

    def index
      @box_specifications = BoxSpecification.page(params[:page])
    end

    def rent
      @box_specifications = BoxSpecification.includes(:available_promotes).page(params[:page])
    end

    def buy
      @box_specifications = BoxSpecification.page(params[:page])
    end

  end
end
