module Ship
  class Share::BoxSpecificationsController < Share::BaseController

    def rent
      @box_specifications = BoxSpecification.includes(:available_promotes).page(params[:page])
    end

    def buy
      @box_specifications = BoxSpecification.page(params[:page])
    end

  end
end
