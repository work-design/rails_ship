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

      belongs_to :loaded_station, class_name: 'Station', optional: true
      belongs_to :unloaded_station, class_name: 'Station', optional: true
      belongs_to :shipment, counter_cache: true
      belongs_to :package, counter_cache: true
      belongs_to :box, counter_cache: true, optional: true

      after_save_commit :sync_state_to_item, if: -> { saved_change_to_state? }
      after_save_commit :sync_current_shipment_item, if: -> { saved_change_to_state? && ['loaded'].include?(state) }
      after_save_commit :remove_current_shipment_item, if: -> { saved_change_to_state? && ['unloaded'].include?(state) }
    end

    def sync_current_shipment_item
      package.current_shipment = shipment
      package.save
    end

    def remove_current_shipment_item
      package.update current_shipment_id: nil
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
