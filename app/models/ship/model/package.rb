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
      attribute :packageds_count, :integer, default: 0
      attribute :shipment_items_count, :integer, default: 0

      enum pick_mode: {
        by_self: 'by_self',
        by_man: 'by_man'
      }
      enum state: {
        init: 'init',
        packaged: 'packaged',
        loaded: 'loaded',
        sent_out: 'sent_out',
        unloaded: 'unloaded',
        delivered: 'delivered',
        received: 'received'
      }, _prefix: true, _default: 'init'

      enum confirm_mode: {
        button: 'button',
        scan: 'scan'
      }, _prefix: true

      belongs_to :organ, class_name: 'Org::Organ', optional: true
      belongs_to :address, class_name: 'Profiled::Address'
      belongs_to :from_address, class_name: 'Profiled::Address', optional: true
      belongs_to :user, class_name: 'Auth::User', optional: true
      belongs_to :produce_plan, class_name: 'Factory::ProducePlan', optional: true if defined? RailsFactory

      belongs_to :from_station, class_name: 'Station', optional: true
      belongs_to :station, optional: true
      belongs_to :box, optional: true
      belongs_to :last_box, class_name: 'Box', optional: true
      belongs_to :current_shipment, class_name: 'Shipment', optional: true

      has_many :shipment_items, inverse_of: :package
      has_many :shipments, through: :shipment_items
      has_many :packageds, dependent: :destroy
      has_many :trade_items, class_name: 'Trade::TradeItem', through: :packageds

      before_validation :sync_station, if: -> { address_id.present? && address_id_changed? }
      before_validation :sync_from_station, if: -> { from_address_id.present? && from_address_id_changed? }
    end

    def sync_station
      return unless address
      self.station_id ||= address.station_id
    end

    def sync_from_station
      return unless from_address
      self.from_station_id ||= from_address.station_id
    end

    def to_cpcl
      cpcl = BaseCpcl.new
      cpcl.text address.detail
      cpcl.text address.area.full_name
      cpcl.right_qrcode(enter_url)
      cpcl.render
    end

    def to_pdf
      pdf = BasePdf.new(width: 78.mm, height: 40.mm)
      pdf.text address.detail, size: 12
      pdf.text organ&.name
      pdf.bounding_box([pdf.bounds.right - 60, pdf.bounds.top], width: 60, height: 60) do
        pdf.image StringIO.new(qrcode_enter_png.to_blob), fit: [60, 60], position: :right, vposition: :top
      end
      pdf
    end

    def qrcode_enter_png
      QrcodeHelper.code_png(enter_url, border_modules: 0, fill: 'pink')
    end

    def enter_url
      Rails.application.routes.url_for(controller: 'ship/packages', action: 'qrcode', id: self.id)
    end

    def qrcode_enter_url
      QrcodeHelper.data_url(enter_url)
    end

  end
end
