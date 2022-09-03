module Ship
  class My::BoxHoldsController < My::BaseController
    before_action :set_box_hold, only: [:show, :edit, :buy, :update, :actions]

    def index
      q_params = { user_id: current_user.id }
      q_params.merge! default_params

      @box_holds = BoxHold.where(q_params)
    end

    def buy
    end

    private
    def set_box_hold
      @box_hold = current_user.box_holds.find params[:id]
    end

  end
end
