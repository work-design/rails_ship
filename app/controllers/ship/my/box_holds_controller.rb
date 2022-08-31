module Ship
  class My::BoxHoldsController < My::BaseController

    def index
      q_params = { user_id: current_user.id, organ_id: nil }

      @box_holds = BoxHold.where(q_params)
    end

  end
end
