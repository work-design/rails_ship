module Ship
  class Admin::StationsController < Admin::BaseController

    def index
      q_params = {}
      q_params.merge! default_params

      @stations = Station.default_where(q_params).page(params[:page])
    end

    def new
      @station = Station.new
      @station.area = Profiled::Area.new
    end

    private
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
