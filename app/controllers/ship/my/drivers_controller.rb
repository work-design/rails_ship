module Ship
  class My::DriversController < My::BaseController
    before_action :set_driver, only: [:show, :edit, :update, :destroy]

    private
    def set_driver
      @driver = current_user.driver || current_user.build_driver
    end

    def driver_params
      params.fetch(:driver, {}).permit(
        :name,
        :number,
        :media_id,
        :license
      )
    end

  end
end
