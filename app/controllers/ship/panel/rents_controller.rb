module Ship
  class Panel::RentsController < Panel::BaseController
    before_action :set_box
    before_action :set_rent, only: [:show, :promote, :edit, :update, :job, :compute]

    def index
      q_params = {
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
      @rent.estimate_finish_at = Time.current
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
        :finish_at
      )
    end

  end
end
