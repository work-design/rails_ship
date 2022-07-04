module Ship
  class Admin::BoxesController < Admin::BaseController
    before_action :set_box_specification
    before_action :set_new_box, only: [:index, :new, :create]

    def index
      @boxes = @box_specification.boxes.includes(:held_organ, :owned_organ).order(id: :desc).page(params[:page])
    end

    def batch
      5.times do
        @box_specification.boxes.build(default_form_params)
      end
      @box_specification.save
    end

    private
    def set_box_specification
      @box_specification = BoxSpecification.find params[:box_specification_id]
    end

    def set_new_box
      @box = @box_specification.boxes.build(box_params)
    end

    def box_params
      p = params.fetch(:box, {}).permit(
        :code,
        :rentable
      )
      p.merge! owned_organ_id: current_organ.id, held_organ_id: current_organ.organ_id if current_organ
      p
    end

  end
end
