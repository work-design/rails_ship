module Ship
  class Buy::RentsController < Buy::BaseController

    def index
      q_params = {
        member_organ_id: current_organ.id
      }
      q_params.merge! params.permit(:id, :payment_type, :payment_status, :state)

      @rents = Lease::Rent.includes(:trade_item).default_where(q_params).order(id: :desc).page(params[:page])
    end

  end
end
