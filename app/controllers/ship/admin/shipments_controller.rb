module Ship
  class Admin::ShipmentsController < Admin::BaseController
    before_action :set_cars, :set_lines, :set_drivers, only: [:new, :create, :edit, :update]
    before_action :set_shipment, only: [:show, :stations, :edit, :update, :destroy]

    def xx
      @shipment.state = 'arrived'
      @shipment.save
    end

    def stations
      @line_stations = @shipment.line.line_stations.includes(:station)
    end

    def packages
      q_params = {
        'address.station_id': params[:station_id]
      }
      @packages = Package.default_where(q_params).page(params[:page])
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
