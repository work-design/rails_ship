module RailsShip::Packaged
  extend ActiveSupport::Concern

  included do
    belongs_to :package, inverse_of: :packageds
    belongs_to :trade_item
  end


end
