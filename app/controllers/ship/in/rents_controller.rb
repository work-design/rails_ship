module Ship
  class In::RentsController < In::BaseController
    before_action :set_box
    before_action :set_rent, only: [:show, :promote, :edit, :update, :job, :compute]

    def index
      q_params = {
        member_organ_id: current_organ.id,
        status: ['ordered', 'paid']
      }
      q_params.merge! params.permit(:id, :payment_type, :payment_status, :state)

      @rents = @box.rents.includes(:item).default_where(q_params).order(id: :desc).page(params[:page])
    end

    def promote
      @promote = @rent.promote
    end

    def job
    end

    def compute
      @rent.compute_amount
      @rent.save
    end

    private
    def set_box
      @box = Box.find params[:box_id]
    end

    def set_rent
      @rent = @box.rents.find params[:id]
    end

    def rent_params
      params.fetch(:rent, {}).permit(
        :estimate_finish_at
      )
    end

  end
end
