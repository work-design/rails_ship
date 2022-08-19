module Ship
  class In::BoxesController < In::BaseController
    before_action :set_box_specifications, only: [:index, :invest, :rent]

    def index
      q_params = {
        held_organ_id: current_organ.id
      }
      q_params.merge! params.permit(:box_specification_id)

      @boxes = Box.includes(:item, :using_box_logs).ordered.order(item_id: :desc).default_where(q_params).page(params[:page])
    end

    def invest
      q_params = {
        owned_organ_id: current_organ.id
      }
      q_params.merge! params.permit(:box_specification_id)

      @boxes = Box.includes(:box_specification, :item).ordered.default_where(q_params).page(params[:page])
    end

    def rent
      q_params = {
        held_organ_id: current_organ.id,
        rented: true
      }
      q_params.merge! params.permit(:box_specification_id)

      @boxes = Box.includes(:box_specification, :item).ordered.default_where(q_params).page(params[:page])
    end

    private
    def set_box_specifications
      @box_specifications = BoxSpecification.all
    end

  end
end
