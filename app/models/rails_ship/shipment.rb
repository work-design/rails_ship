module RailsShip::Shipment
  extend ActiveSupport::Concern

  included do
    belongs_to :package
    belongs_to :shipping, polymorphic: true
  end

  def xx

  end

end
