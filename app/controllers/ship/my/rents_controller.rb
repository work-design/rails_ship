module Ship
  class My::RentsController < In::RentsController
    before_action :set_new_rent

    def create

    end

    private
    def set_new_rent
      @rent = @box.rents.build(rent_params)
    end

    def rent_params
      params.fetch(:rent, {}).permit(
        :finish_at
      )
    end

  end
end

