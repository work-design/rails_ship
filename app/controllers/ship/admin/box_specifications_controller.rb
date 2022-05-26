module Ship
  class Admin::BoxSpecificationsController < Admin::BaseController

    def rent
      @box_specifications = BoxSpecification.page(params[:page])
    end

    def buy
      @box_specifications = BoxSpecification.page(params[:page])
    end

  end
end
