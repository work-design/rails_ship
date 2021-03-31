module Ship
  class DriverOcrJob < ApplicationJob

    def perform(driver)
      driver.ocr
    end

  end
end

