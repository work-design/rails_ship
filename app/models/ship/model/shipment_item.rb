module Ship
  module Model::ShipmentItem
    extend ActiveSupport::Concern

    included do
      attribute :loaded_at, :datetime
      attribute :unloaded_at, :datetime

      belongs_to :item, polymorphic: true
      belongs_to :shipment
    end

  end
end
