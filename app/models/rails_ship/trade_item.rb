module RailsShip::TradeItem
  extend ActiveSupport::Concern

  included do
    has_many :packageds, dependent: :delete_all
    has_many :packages, through: :packageds
  end

end
