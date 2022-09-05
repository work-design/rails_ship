module Ship
  module Model::BoxHold
    extend ActiveSupport::Concern

    included do
      attribute :boxes_count, :integer, default: 0
      attribute :sellable, :integer
      attribute :sell_price, :decimal
      attribute :buyable, :integer
      attribute :buy_price, :decimal

      belongs_to :box_specification
      belongs_to :organ, class_name: 'Org::Organ', optional: true

      belongs_to :user, class_name: 'Auth::User'
      belongs_to :member, class_name: 'Org::Member', optional: true
      belongs_to :member_organ, class_name: 'Org::Organ', optional: true
      belongs_to :box_host, ->(o) { where(organ_id: o.organ_id) }, foreign_key: :box_specification_id, primary_key: :box_specification_id, optional: true
      belongs_to :box_sell, ->(o){ where(organ_id: o.organ_id, price: o.sell_price) }, foreign_key: :box_specification_id, primary_key: :box_specification_id, optional: true
      belongs_to :box_buy, ->(o){ where(organ_id: o.organ_id, price: o.buy_price) }, foreign_key: :box_specification_id, primary_key: :box_specification_id, optional: true

      has_many :boxes, ->(o){ where(organ_id: o.organ_id, held_user_id: o.user_id) }, primary_key: :box_specification_id, foreign_key: :box_specification_id
      has_many :host_items, ->(o){ where(organ_id: o.organ_id, good_type: 'Ship::BoxHost', good_id: o.box_host&.id, member_id: o.member_id) }, class_name: 'Trade::Item', primary_key: :user_id, foreign_key: :user_id
      has_many :sell_items, ->(o){ where(organ_id: o.organ_id, good_type: 'Ship::BoxSell', good_id: o.box_sell&.id, member_id: o.member_id) }, class_name: 'Trade::Item', primary_key: :user_id, foreign_key: :user_id

      before_validation :init_box_sell, if: -> { sell_price.present? && (['sell_price', 'sellable'] & changes.keys).present? }
      before_validation :init_box_buy, if: -> { buy_price.present? && (['buy_price', 'buyable'] & changes.keys).present? }
    end

    def init_box_sell
      box_sell || build_box_sell
    end

    def init_box_buy
      box_buy || build_box_buy
    end

  end
end
