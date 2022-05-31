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

      after_save_commit :sync_state_to_item, if: -> { saved_change_to_state? }
    end

    def sync_state_to_item
      item.state = self.state
      item.loaded_at = self.loaded_at
      item.unloaded_at = self.unloaded_at
      item.save
    end

  end
end
