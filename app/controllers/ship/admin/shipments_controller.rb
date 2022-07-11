module Ship
  class Admin::ShipmentsController < Admin::BaseController
    before_action :set_cars, :set_lines, :set_drivers, only: [:new, :create, :edit, :update]
    before_action :set_shipment, only: [:show, :stations, :edit, :update, :destroy]

    def xx
      @shipment.state = 'arrived'
      @shipment.save
    end

    def stations
      @stations = @shipment.line.stations
    end

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

    def set_shipment
      @shipment = Shipment.find params[:id]
    end

  end
end
