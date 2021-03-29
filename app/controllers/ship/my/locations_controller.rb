module Ship
  class My::LocationsController < My::BaseController
    before_action :set_line
    before_action :set_location, only: [:show, :edit, :update, :destroy]

    def index
      @locations = Location.page(params[:page])
    end

    def new
      @location = Location.new
    end

    def create
      @location = Location.new(location_params)

      unless @location.save
        render :new, locals: { model: @location }, status: :unprocessable_entity
      end
    end

    def show
    end

    def edit
    end

    def update
      @location.assign_attributes(location_params)

      unless @location.save
        render :edit, locals: { model: @location }, status: :unprocessable_entity
      end
    end

    def destroy
      @location.destroy
    end

    private
    def set_line
      @line = Line.find params[:line_id]
    end

    def set_location
      @location = Location.find(params[:id])
    end

    def location_params
      params.fetch(:location, {}).permit(
        :poiname,
        :poiaddress,
        :cityname,
        :lat,
        :lng
      )
    end

  end
end
