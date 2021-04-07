module Ship
  class DriverOcrJob < ApplicationJob

    def perform(driver)
      driver.ocr
      driver.for_update
    end

  end
end

