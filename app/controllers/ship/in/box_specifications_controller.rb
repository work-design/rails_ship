module Ship
  class In::BoxSpecificationsController < In::BaseController
    before_action :set_rent_cart, only: [:rent]
    before_action :set_use_cart, only: [:buy]

    def index
      q_params = {}

      @box_specifications = BoxSpecification.page(params[:page])
    end

    def rent
      @box_hosts = BoxHost.includes(:available_promotes).page(params[:page])
    end

    def buy
      @box_hosts = BoxHost.page(params[:page])
    end

    private
    def set_rent_cart
      @cart = current_organ.organ_carts.find_or_create_by(good_type: 'Ship::BoxHost', aim: 'rent')
    end

    def set_use_cart
      @cart = current_organ.organ_carts.find_or_create_by(good_type: 'Ship::BoxHost', aim: 'use')
    end

  end
end
