module Ship
  module Model::PackageShipment
    extend ActiveSupport::Concern

    included do
      belongs_to :box, optional: true
      belongs_to :package
      belongs_to :shipment
    end

  end
end
