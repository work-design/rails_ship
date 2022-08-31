module Ship
  class My::BoxHoldsController < My::BaseController

    def index
      q_params = { user_id: current_user.id }

      @box_holds = BoxHold.default_where(q_params)
    end

  end
end
