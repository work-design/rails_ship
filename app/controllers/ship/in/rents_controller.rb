module Ship
  class In::RentsController < In::BaseController
    before_action :set_rent, only: [:show, :promote, :edit, :update, :job, :compute]

    def index
      q_params = {
        member_organ_id: current_organ.id,
        status: ['ordered', 'paid']
      }
      q_params.merge! params.permit(:id, :payment_type, :payment_status, :state)

      @rents = Trade::Rent.includes(:trade_item).default_where(q_params).order(id: :desc).page(params[:page])
    end

    def promote
      @promote = @rent.promote
    end

    def job
    end

    def compute
      @rent.compute_later
    end

    private
    def set_rent
      @rent = Trade::TradeItem.find params[:id]
    end

    def rent_params
      params.fetch(:rent, {}).permit(
        :estimate_finish_at
      )
    end

  end
end
