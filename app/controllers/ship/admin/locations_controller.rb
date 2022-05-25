module Ship
  class Admin::LocationsController < Admin::BaseController
    before_action :set_line
    before_action :set_new_location, only: [:new, :create]

    def index
      @locations = @line.locations.page(params[:page])
    end

    private
    def set_line
      @line = Line.find params[:line_id]
    end

    def set_new_location
      @location = @line.locations.build(location_params)
    end

    def location_params
      params.fetch(:location, {}).permit(
        :name
      )
    end

  end
end
