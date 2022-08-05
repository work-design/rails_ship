module Ship
  module Model::ShipmentItem
    extend ActiveSupport::Concern

    included do
      attribute :loaded_at, :datetime
      attribute :unloaded_at, :datetime

      enum confirm_mode: {
        button: 'button',
        scan: 'scan',
        batch: 'batch'
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
      belongs_to :station, optional: true
      belongs_to :box, counter_cache: true, optional: true

      has_many :trade_items, through: :package
      has_many :orders, class_name: 'Trade::Order', through: :trade_items
      has_many :payment_orders, class_name: 'Trade::PaymentOrder', through: :trade_items

      before_save :sync_station_from_package, if: -> { package_id.present? && package_id_changed? }
      after_save_commit :sync_state_to_item, if: -> { saved_change_to_state? }
    end

    def sync_station_from_package
      return unless package
      self.station_id = package.station_id
    end

    def sync_state_to_item
      package.state = self.state
      if ['loaded'].include?(state)
        package.current_shipment = shipment
      elsif ['unloaded'].include?(state)
        package.current_shipment_id = nil
      end

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
