module Ship
  class In::BoxSpecificationsController < In::BaseController
    before_action :set_rent_cart, only: [:rent]
    before_action :set_use_cart, only: [:buy]

    def index
      @box_specifications = BoxSpecification.page(params[:page])
    end

    def rent
      @box_specifications = BoxSpecification.includes(:available_promotes).page(params[:page])
    end

    def buy
      @box_specifications = BoxSpecification.page(params[:page])
    end

    private
    def set_rent_cart
      @cart = current_organ.organ_carts.find_or_create_by(good_type: 'Ship::BoxSpecification', aim: 'rent')
    end

    def set_use_cart
      @cart = current_organ.organ_carts.find_or_create_by(good_type: 'Ship::BoxSpecification', aim: 'use')
    end

  end
end
