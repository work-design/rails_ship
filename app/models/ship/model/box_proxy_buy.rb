module Ship
  module Model::BoxProxyBuy
    extend ActiveSupport::Concern

    included do
      attribute :buyable_count, :integer, default: 0
      attribute :price, :decimal

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      belongs_to :box_specification
      belongs_to :box_host

      has_many :box_sells, ->(o) { default_where(organ_id: o.organ_id, 'price-lte': o.price) }, primary_key: :box_specification_id, foreign_key: :box_specification_id
      has_many :items, ->(o) { where(good_type: 'Ship::BoxHost', single_price: o.price) }, primary_key: :box_host_id, foreign_key: :good_id

      before_save :sync_from_box_host, if: -> { box_host_id_changed? }
    end

    def sync_from_box_host
      self.organ = box_host.ogran
      self.box_specification = box_host.box_specification
    end

    def reset_buyable_count
      self.buyable_count = items.default_where('rest_number-gt': 0).count
    end

  end
end
