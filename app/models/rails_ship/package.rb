module RailsShip::Package
  extend ActiveSupport::Concern

  included do
    belongs_to :shipment
    has_many :packageds, dependent: :delete_all
    has_many :trade_items, through: :packageds
  end

end
