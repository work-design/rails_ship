module Ship
  class Buy::RentsController < Buy::BaseController
    before_action :set_rent, only: [:show, :promote, :edit, :update]

    def index
      q_params = {
        member_organ_id: current_organ.id
      }
      q_params.merge! params.permit(:id, :payment_type, :payment_status, :state)

      @rents = Lease::Rent.includes(trade_item: :order).default_where(q_params).order(id: :desc).page(params[:page])
    end

    def promote
      @promote = @rent.trade_item.good.available_promotes[0]
    end

    private
    def set_rent
      @rent = Lease::Rent.find params[:id]
    end

    def rent_params
      params.fetch(:rent, {}).permit(
        :estimate_finish_at
      )
    end

  end
end
