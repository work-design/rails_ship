class TradeItem < ApplicationRecord
  include RailsTrade::TradeItem
  include RailsShip::TradeItem
end unless defined? TradeItem
