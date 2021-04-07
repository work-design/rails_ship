module Ship
  class LocationGeoJob < ApplicationJob

    def perform(location)
      location.geo
    end

  end
end

