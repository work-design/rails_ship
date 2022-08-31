module Ship
  class My::BoxHoldsController < My::BaseController

    def index
      q_params = { user_id: current_user.id }
      q_params.merge! default_params

      @box_holds = BoxHold.where(q_params)
    end

  end
end
