module Ship
  class Admin::ShipmentsController < Admin::BaseController
    before_action :set_cars, :set_lines, :set_drivers, only: [:new, :create, :edit, :update]
    before_action :set_shipment, only: [:show, :stations, :unloaded, :transfer, :loaded, :loaded_create, :edit, :update, :destroy]
    before_action :set_station, only: [:unloaded, :transfer]
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

      @packages = @shipment.packages.default_where(q_params).order(id: :desc).page(params[:page])
    end

    def transfer
      q_params = {
      }

      @packages = @shipment.packages.where.not(station_id: @shipment.line.line_stations.pluck(:station_id)).default_where(q_params).page(params[:page])
    end

    def loaded
      q_params = {}
      q_params.merge! params.permit(:from_station_id, :station_id)

      @packages = Package.default_where(q_params).order(id: :desc).page(params[:page])
    end

    def loaded_create
      packages = Package.find params[:ids].split(',')

      ss = packages.map do |package|
        si = @shipment.shipment_items.find_or_initialize_by(package_id: package.id)
        si.state = 'loaded'
        si.loaded_at ||= Time.current
        si
      end
      @shipment.class.transaction do
        ss.each(&:save)
      end
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
