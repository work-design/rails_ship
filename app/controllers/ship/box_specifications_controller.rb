module Ship
  class BoxSpecificationsController < BaseController
    before_action :set_box_specification, only: [:show]
    before_action :set_cart, only: [:index, :rent]

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

    def set_cart
      @cart = current_carts.find_or_create_by(good_type: 'Ship::BoxSpecification')
    end

  end
end
