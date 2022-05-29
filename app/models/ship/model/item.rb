module Ship
  module Model::Item
    extend ActiveSupport::Concern

    included do
      attribute :package_name, :string
      attribute :package_number, :integer
      attribute :package_kind, :string
      attribute :weight, :integer
      attribute :volume, :integer
      attribute :price, :decimal
      attribute :settle_ratio, :integer, comment: '预付比例'

      enum settle_kind: {
        spot_payment: 'spot_payment',
        freight_collect: 'freight_collect',
        included_goods: 'included_goods'
      }
      enum settle_period: {
        daily: 'daily',
        weekly: 'weekly',
        monthly: 'monthly',
        bimonthly: 'bimonthly',
        quarterly: 'quarterly'
      }
      enum weight_unit: {
        gram: 'gram',
        kilogram: 'kilogram'
      }
      enum volume_unit: {
        cubic_meter: 'cubic_meter',
        cubic_kilometer: 'cubic_kilometer',
        cubic_millimeter: 'cubic_millimeter'
      }

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      belongs_to :package, optional: true
      belongs_to :box, optional: true
      belongs_to :destination, class_name: 'Profiled::Address', optional: true
      belongs_to :departure, class_name: 'Profiled::Address', optional: true

      has_many :item_shipments, dependent: :destroy_async
      has_many :shipment, through: :item_shipments
    end

  end
end
