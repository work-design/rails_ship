module Ship
  class Panel::StationsController < Panel::BaseController

    def index
      q_params = {}

      @stations = Station.includes(:area).default_where(q_params).order(id: :asc).page(params[:page])
    end

  end
end
