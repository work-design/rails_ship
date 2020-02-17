class Rally < ApplicationRecord
  include RailsShip::Rally
  include RailsShip::Shipping
end unless defined? Rally
