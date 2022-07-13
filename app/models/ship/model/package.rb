module Ship
  module Model::Package
    extend ActiveSupport::Concern

    included do
      attribute :state, :string
      attribute :expected_on, :date
      attribute :pick_mode, :string
      attribute :confirm_mode, :string
      attribute :boxed_in_at, :datetime
      attribute :boxed_out_at, :datetime
      attribute :loaded_at, :datetime
      attribute :unloaded_at, :datetime
      attribute :packageds_count, :integer, default: 0

      belongs_to :organ, class_name: 'Org::Organ', optional: true
      belongs_to :address, class_name: 'Profiled::Address'
      belongs_to :user, class_name: 'Auth::User', optional: true
      belongs_to :produce_plan, class_name: 'Factory::ProducePlan', optional: true if defined? RailsFactory

      belongs_to :box, optional: true
      belongs_to :last_box, class_name: 'Box', optional: true

      has_one :shipment_item, -> { order(id: :desc) }
      has_many :shipment_items
      has_many :shipments, through: :shipment_items
      has_many :packageds, dependent: :destroy
      has_many :trade_items, class_name: 'Trade::TradeItem', through: :packageds

      enum pick_mode: {
        by_self: 'by_self',
        by_man: 'by_man'
      }
      enum state: {
        init: 'init',
        packaged: 'packaged',
        box_in: 'box_in',
        loaded: 'loaded',
        sent_out: 'sent_out',
        unloaded: 'unloaded',
        box_out: 'box_out',
        delivered: 'delivered',
        received: 'received'
      }, _prefix: true, _default: 'init'

      enum confirm_mode: {
        button: 'button',
        scan: 'scan'
      }, _prefix: true
    end

    def enter_url
      Rails.application.routes.url_for(controller: 'ship/packages', action: 'qrcode', id: self.id)
    end

    def qrcode_enter_url
      QrcodeHelper.data_url(enter_url)
    end

  end
end
