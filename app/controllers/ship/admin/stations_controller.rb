module Ship
  class Admin::StationsController < Admin::BaseController
    before_action :set_new_station, only: [:new, :create]

    def index
      q_params = {}
      q_params.merge! default_params

      @stations = Station.includes(:area).default_where(q_params).order(id: :asc).page(params[:page])
    end

    def new
      if defined?(current_organ) && current_organ
        @station.area = current_organ.area
      else
        @station.area = Profiled::Area.new
      end
    end

    private
    def set_new_station
      @station = Station.new(station_params)
    end

    def station_params
      p = params.fetch(:station, {}).permit(
        :name,
        :detail,
        :area_ancestors
      )
      p.merge! default_form_params
    end

  end
end
