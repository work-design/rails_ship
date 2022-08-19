module Ship
  class Me::RentsController < In::RentsController

    def rent_params
      params.fetch(:rent, {}).permit(
        :finish_at
      )
    end

  end
end

