module Ship
  class Admin::RentsController < Admin::BaseController
    before_action :set_box
    before_action :set_rent, only: [:show, :edit, :update, :destroy, :actions]

    def index
      @rents = @box.rents.order(id: :desc).page(params[:page])
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
        :start_at,
        :finish_at,
        :estimate_finish_at
      )
    end
  end
end
