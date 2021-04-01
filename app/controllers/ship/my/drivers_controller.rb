module Ship
  class My::DriversController < My::BaseController
    before_action :set_driver, only: [:show, :edit, :update, :destroy]

    def show
    end

    def edit
    end

    def update
      @driver.assign_attributes(driver_params)

      unless @driver.save
        render :edit, locals: { model: @driver }, status: :unprocessable_entity
      end
    end

    def destroy
      @driver.destroy
    end

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
