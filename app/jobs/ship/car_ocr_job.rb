module Ship
  class CarOcrJob < ApplicationJob

    def perform(car)
      car.ocr
    end

  end
end

