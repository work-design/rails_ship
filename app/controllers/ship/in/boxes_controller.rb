module Ship
  class In::BoxesController < In::BaseController
    before_action :set_box_specifications, only: [:index, :invest, :rent]

    def index
      q_params = {
        held_organ_id: current_organ.id
      }
      q_params.merge! params.permit(:box_specification_id)

      @boxes = Box.includes(:box_specification, :using_box_logs, :shipment_items).default_where(q_params).page(params[:page])
    end

    def invest
      q_params = {
        held_organ_id: current_organ.id
      }
      q_params.merge! params.permit(:box_specification_id)

      @boxes = Box.includes(:box_specification).default_where(q_params).page(params[:page])
    end

    def rent
      q_params = {
        held_organ_id: current_organ.id,
        rented: true
      }
      q_params.merge! params.permit(:box_specification_id)

      @boxes = Box.includes(:box_specification).default_where(q_params).page(params[:page])
    end

    private
    def set_box_specifications
      @box_specifications = BoxSpecification.all
    end

  end
end
