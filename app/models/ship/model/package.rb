module Ship
  module Model::Package
    extend ActiveSupport::Concern

    included do
      attribute :state, :string
      attribute :expected_on, :date
      attribute :pick_mode, :string

      belongs_to :address, class_name: 'Profiled::Address'
      belongs_to :user, class_name: 'Auth::User', optional: true
      belongs_to :produce_plan, class_name: 'Factory::ProducePlan', optional: true if defined? RailsFactory

      belongs_to :box, optional: true

      has_many :package_shipments, dependent: :destroy_async
      has_many :shipments, through: :package_shipments
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
        box_out: 'box_out',
        delivered: 'delivered',
        received: 'received'
      }, _prefix: true
    end

    def enter_url
      Rails.application.routes.url_for(controller: 'ship/me/packages', action: 'qrcode', id: self.id)
    end

    def qrcode_enter_url
      QrcodeHelper.data_url(enter_url)
    end

  end
end
