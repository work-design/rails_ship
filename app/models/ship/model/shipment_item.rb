module Ship
  module Model::ShipmentItem
    extend ActiveSupport::Concern

    included do
      attribute :loaded_at, :datetime
      attribute :unloaded_at, :datetime

      enum state: {
        loaded: 'loaded',
        unloaded: 'unloaded'
      }, _prefix: true

      belongs_to :item, polymorphic: true
      belongs_to :shipment
    end

  end
end
