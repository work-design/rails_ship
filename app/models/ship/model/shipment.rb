module Ship
  module Model::Shipment
    extend ActiveSupport::Concern

    included do
      attribute :type, :string
      attribute :expected_leave_at, :datetime
      attribute :expected_arrive_at, :datetime
      attribute :left_at, :datetime
      attribute :arrived_at, :datetime
      attribute :load_on, :date
      attribute :shipment_items_count, :integer, default: 0
      attribute :expected_minutes, :integer, comment: '预计路途分钟数'

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      belongs_to :line
      belongs_to :car
      belongs_to :driver
      belongs_to :current_station, class_name: 'Station', optional: true
      belongs_to :shipping, polymorphic: true, optional: true

      has_many :shipment_items, dependent: :destroy_async
      has_many :packages, through: :shipment_items
      has_many :loaded_shipment_items, -> { state_loaded }, class_name: 'ShipmentItem'
      has_many :loaded_packages, through: :loaded_shipment_items, source: :package
      has_many :unloaded_shipment_items, -> { state_unloaded }, class_name: 'ShipmentItem'
      has_many :unloaded_packages, through: :unloaded_shipment_items, source: :package
      has_many :boxes, through: :shipment_items

      enum state: {
        preparing: 'preparing',
        prepared: 'prepared',
        left: 'left',
        arrived: 'arrived'
      }, _prefix: true, _default: 'preparing'

      before_save :change_state_to_left, if: -> { left_at && left_at_changed? }
      before_save :change_state_to_arrived, if: -> { arrived_at && arrived_at_changed? }
      after_save_commit :sync_state_to_item, if: -> { saved_change_to_state? }
    end

    def change_state_to_left
      self.state = 'left'
    end

    def change_state_to_arrived
      self.state = 'arrived'
    end

    def sync_state_to_item
      shipment_items.each do |shipment_item|
        shipment_item.state = 'unloaded'
        shipment_item.unload_at = Time.current
        shipment_item.save
      end
    end

    def enter_url
      Rails.application.routes.url_for(controller: 'ship/shipments', action: 'qrcode', id: self.id)
    end

    def qrcode_enter_url
      QrcodeHelper.data_url(enter_url)
    end

  end
end
