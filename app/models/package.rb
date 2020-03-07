class Package < ApplicationRecord
  include RailsShip::Package
  include RailsWait::Waiting if defined? RailsWait
end unless defined? Package
