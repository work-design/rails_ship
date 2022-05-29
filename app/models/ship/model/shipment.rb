module Ship
  module Model::Shipment
    extend ActiveSupport::Concern

    included do
      attribute :type, :string
      attribute :left_at, :datetime
      attribute :arrived_at, :datetime
      attribute :load_on, :date

      belongs_to :line
      belongs_to :car
      belongs_to :driver
      belongs_to :shipping, polymorphic: true, optional: true

      has_many :item_shipments, dependent: :destroy_async
      has_many :items, through: :item_shipments
      has_many :shipment_packages, dependent: :destroy_async
      has_many :packages, through: :shipment_packages

      enum state: {
        prepared: 'prepared',
        left: 'left',
        arrived: 'arrived'
      }, _prefix: true
    end

    def enter_url
      Rails.application.routes.url_for(controller: 'ship/me/shipments', action: 'qrcode', id: self.id)
    end

    def qrcode_enter_url
      QrcodeHelper.data_url(enter_url)
    end

  end
end
