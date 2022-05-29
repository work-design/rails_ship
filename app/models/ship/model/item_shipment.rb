module Ship
  module Model::ItemShipment
    extend ActiveSupport::Concern

    included do
      belongs_to :item
      belongs_to :shipment
    end

  end
end
