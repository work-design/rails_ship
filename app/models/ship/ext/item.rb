module Ship
  module Ext::Item
    extend ActiveSupport::Concern

    included do
      has_many :packageds, class_name: 'Ship::Packaged', foreign_key: :trade_item_id, dependent: :destroy_async
      has_many :packages, class_name: 'Ship::Package', through: :packageds

      belongs_to :box_hold, ->(o) { where(organ_id: o.organ_id, member_id: o.member_id, box_specification_id: o.good.box_specification_id) }, class_name: 'Ship::BoxHold', foreign_key: :user_id, primary_key: :user_id, optional: true
      belongs_to :box_proxy_buy, ->(o) { where(box_specification_id: o.good.box_specification_id, price: o.single_price) }, class_name: 'Ship::BoxProxyBuy', foreign_key: :organ_id, primary_key: :organ_id, optional: true

      after_save_commit :init_box_hold, if: -> { good.respond_to?(:box_specification_id) && saved_change_to_status? && ['deliverable'].include?(status) }
      after_save_commit :init_box_proxy_buy, if: -> { good.respond_to?(:box_specification_id) && saved_change_to_status? && ['deliverable'].include?(status) }
    end

    def init_box_hold
      box_hold || build_box_hold
      box_hold.save
    end

    def init_box_proxy_buy
      box_proxy_buy || build_box_proxy_buy
      box_proxy_buy.save
    end

  end
end
