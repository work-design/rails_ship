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

      enum status: {
        never_loaded: 'never_loaded'
      }, _prefix: true

      belongs_to :shipment, counter_cache: true
      belongs_to :package
      belongs_to :box, optional: true

      after_save_commit :sync_state_to_item, if: -> { saved_change_to_state? }
    end

    def sync_state_to_item
      package.state = self.state
      package.loaded_at = self.loaded_at
      package.unloaded_at = self.unloaded_at

      if box
        box.state = self.state
        box.loaded_at = self.loaded_at
        box.unloaded_at = self.unloaded_at

        self.class.transaction do
          box.save!
          package.save!
        end
      else
        package.save
      end
    end

  end
end
