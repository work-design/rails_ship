module Ship
  class Admin::ShipmentsController < Admin::BaseController
    before_action :set_cars, :set_lines, :set_drivers, only: [:new, :create, :edit, :update]
    before_action :set_shipment, only: [:show, :stations, :unloaded, :loaded, :edit, :update, :destroy]
    before_action :set_station, only: [:unloaded]
    before_action :set_from_station, only: [:loaded]

    def xx
      @shipment.state = 'arrived'
      @shipment.save
    end

    def stations
      @line_stations = @shipment.line.line_stations.includes(:station)
    end

    def unloaded
      q_params = {}
      q_params.merge! params.permit(:station_id)

      @packages = @shipment.packages.default_where(q_params).page(params[:page])
    end

    def loaded
      q_params = {}
      q_params.merge! params.permit(:from_station_id, :station_id)

      @packages = Package.default_where(q_params).page(params[:page])
    end

    def loaded_create
      packages = Package.find params[:ids].split(',')

      packages.each do |package|
        @shipment.shipment_items.build(package_id: package.id)
      end
      @shipment.save
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

    def set_from_station
      @station = Station.find params[:from_station_id]
    end

    def set_station
      @station = Station.find params[:station_id]
    end

  end
end
