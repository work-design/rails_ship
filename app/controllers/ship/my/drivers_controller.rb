module Ship
  class My::DriversController < My::BaseController
    before_action :set_driver, only: [:show, :edit, :update, :destroy]

    def index
      @drivers = Driver.page(params[:page])
    end

    def new
      @driver = Driver.new
    end

    def create
      @driver = Driver.new(driver_params)

      unless @driver.save
        render :new, locals: { model: @driver }, status: :unprocessable_entity
      end
    end

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
      @driver = Driver.find(params[:id])
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
