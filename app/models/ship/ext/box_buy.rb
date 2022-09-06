module Ship
  module Ext::BoxBuy
    extend ActiveSupport::Concern

    included do
      belongs_to :box_proxy_buy, ->(o){ where(organ_id: o.organ_id, price: o.price) }, foreign_key: :box_specification_id, primary_key: :box_specification_id, optional: true
      belongs_to :box_proxy_sell, ->(o){ where(organ_id: o.organ_id, price: o.price) }, foreign_key: :box_specification_id, primary_key: :box_specification_id, optional: true

      has_many :box_holds, ->(o){ where(organ_id: o.organ_id, buy_price: o.price) }, primary_key: :box_specification_id, foreign_key: :box_specification_id
      has_many :box_sells, ->(o) { default_where(organ_id: o.organ_id, 'price-lte': o.price) }, primary_key: :box_specification_id, foreign_key: :box_specification_id

      before_validation :init_box_proxy_buy, if: -> { price.present? && (['price', 'amount'] & changes.keys).present? }
    end

    def init_box_proxy_buy
      box_proxy_buy || build_box_proxy_buy
      box_proxy_sell || build_box_proxy_sell
    end

    def trigger_buy

    end

  end
end
