module Ship
  class CarOcrJob < ApplicationJob

    def perform(car)
      car.ocr
      car.for_update
    end

  end
end

