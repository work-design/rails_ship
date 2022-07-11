module Ship
  class Admin::LineStationsController < Admin::BaseController
    before_action :set_line
    before_action :set_new_line_station, only: [:new, :create]
    before_action :set_stations, only: [:new, :create, :edit, :update]

    def index
      @line_stations = @line.line_stations.includes(:station).page(params[:page])
    end

    private
    def set_line
      @line = Line.find params[:line_id]
    end

    def set_new_line_station
      @line_station = @line.line_stations.build(line_station_params)
    end

    def set_stations
      @stations = Station.default_where(default_params)
    end

    def line_station_params
      params.fetch(:line_station, {}).permit(
        :station_id
      )
    end

  end
end
