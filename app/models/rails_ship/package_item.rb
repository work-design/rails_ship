module RailsShip::PackageItem
  extend ActiveSupport::Concern

  included do
    belongs_to :package
    belongs_to :trade_item
  end


end
