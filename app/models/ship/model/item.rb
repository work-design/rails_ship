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

      has_many :item_shipments, dependent: :destroy_async
      has_many :shipment, through: :item_shipments
    end

  end
end
