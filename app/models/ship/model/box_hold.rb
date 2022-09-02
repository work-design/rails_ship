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
      belongs_to :box_sell, ->(o){ where(organ_id: o.organ_id, box_specification_id: o.box_specification_id) }, foreign_key: :sale_price, primary_key: :price, optional: true
      belongs_to :box_buy, ->(o){ where(organ_id: o.organ_id, box_specification_id: o.box_specification_id) }, foreign_key: :buy_price, primary_key: :price, optional: true

      has_many :boxes, ->(o){ where(organ_id: o.organ_id, held_user_id: o.user_id) }, primary_key: :box_specification_id, foreign_key: :box_specification_id

      before_validation :init_box_sell, if: -> { sell_price.present? && (['sell_price', 'sellable'].keys & changes.keys).present? }
      before_validation :init_box_buy, if: -> { buy_price.present? && (['buy_price', 'buyable'].keys & changes.keys).present? }
    end

    def init_box_sell
      box_sell || build_box_sell
    end

    def init_box_buy
      box_buy || build_box_buy
    end

  end
end
