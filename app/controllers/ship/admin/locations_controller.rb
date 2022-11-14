module Ship
  class Admin::LocationsController < Admin::BaseController
    before_action :set_way

    def index
      @locations = @way.locations.includes(:station).page(params[:page])
    end

    private
    def set_way
      @way = Way.find params[:way_id]
    end

    def set_new_location
      @location = @way.locations.build(location_params)
    end

    def set_stations
      @stations = Station.where.not(id: @way.station_ids).default_where(default_params)
    end

    def location_params
      params.fetch(:location, {}).permit(
        :station_id
      )
    end

  end
end
