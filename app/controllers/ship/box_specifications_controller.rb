module Ship
  class BoxSpecificationsController < BaseController
    before_action :set_box_specification, only: [:show]
    before_action :set_use_cart, only: [:index]
    before_action :set_rent_cart, only: [:rent]
    before_action :set_cart, only: [:show]

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
      @cart = current_carts.find_or_create_by(good_type: 'Ship::BoxSpecification', aim: nil)
    end

    def set_use_cart
      @cart = current_carts.find_or_create_by(good_type: 'Ship::BoxSpecification', aim: 'use')
    end

    def set_rent_cart
      @cart = current_carts.find_or_create_by(good_type: 'Ship::BoxSpecification', aim: 'rent')
    end

  end
end
