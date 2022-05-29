module Ship
  class Admin::ShipmentsController < Admin::BaseController
    before_action :set_cars, :set_lines, :set_drivers, only: [:new, :create, :edit, :update]

    private
    def set_cars
      @cars = Car.default_where(default_params)
    end

    def set_lines
      @lines = Line.default_where(default_params)
    end

    def set_drivers
      @drivers = Driver.default_where(default_params)
    end

  end
end
