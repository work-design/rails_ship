class Packaged < ApplicationRecord
  include RailsShip::Packaged
end unless defined? Packaged
