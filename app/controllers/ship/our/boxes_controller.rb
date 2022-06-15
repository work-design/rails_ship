module Ship
  class Our::BoxesController < My::BoxesController

    def index
      @boxes = current_organ.boxes.includes(:box_specification).order(id: :desc).page(params[:page])
    end

    private
    def rental_params
      params.fetch(:financial, {}).permit(
        :cost,
        :logo
      )
    end

  end
end
