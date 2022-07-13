module Ship
  module Model::ShipmentItem
    extend ActiveSupport::Concern

    included do
      attribute :loaded_at, :datetime
      attribute :unloaded_at, :datetime

      enum confirm_mode: {
        button: 'button',
        scan: 'scan'
      }, _prefix: true

      enum state: {
        loaded: 'loaded',
        unloaded: 'unloaded'
      }, _prefix: true

      enum status: {
        never_loaded: 'never_loaded'
      }, _prefix: true

      belongs_to :shipment, counter_cache: true
      belongs_to :package, counter_cache: true
      belongs_to :box, counter_cache: true, optional: true

      after_save_commit :sync_state_to_item, if: -> { saved_change_to_state? }
    end

    def sync_state_to_item
      package.state = self.state

      if box
        box.state = self.state
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
