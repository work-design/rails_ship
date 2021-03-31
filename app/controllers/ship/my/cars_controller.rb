module Ship
  class My::CarsController < My::BaseController
    before_action :set_car, only: [:show, :edit, :update, :destroy]

    def index
      @cars = Car.page(params[:page])
    end

    def new
      @car = current_user.cars.build
    end

    def create
      @car = current_user.cars.build(car_params)
      binding.pry
      unless @car.save
        render :new, locals: { model: @car }, status: :unprocessable_entity
      end
    end

    def show
    end

    def edit
    end

    def update
      @car.assign_attributes(car_params)

      unless @car.save
        render :edit, locals: { model: @car }, status: :unprocessable_entity
      end
    end

    def destroy
      @car.destroy
    end

    private
    def set_car
      @car = Car.find(params[:id])
    end

    def car_params
      params.fetch(:car, {}).permit(
        :location,
        :number,
        :media_id,
        :registration
      )
    end

  end
end
