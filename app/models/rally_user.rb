class RallyUser < ApplicationRecord
  include RailsShip::RallyUser
end unless defined? RallyUser
