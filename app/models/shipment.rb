class Shipment < ApplicationRecord
  include RailsShip::Shipment
end unless defined? Shipment
