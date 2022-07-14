module Ship
  class Admin::LinesController < Admin::BaseController

    def index
      q_params = {
        'line_stations.organ_id': current_organ.id
      }

      @lines = Line.default_where(q_params).page(params[:page])
    end

  end
end
