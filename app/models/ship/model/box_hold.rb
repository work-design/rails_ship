module Ship
  module Model::BoxHold
    extend ActiveSupport::Concern

    included do
      attribute :boxes_count, :integer, default: 0
      attribute :saleable, :integer
      attribute :sale_price, :decimal
      attribute :buyable, :integer
      attribute :buy_price, :decimal

      belongs_to :box_specification
      belongs_to :organ, class_name: 'Org::Organ', optional: true

      belongs_to :user, class_name: 'Auth::User'
      belongs_to :member, class_name: 'Org::Member', optional: true
      belongs_to :member_organ, class_name: 'Org::Organ', optional: true
      belongs_to :box_sell, ->(o){ where(organ_id: o.organ_id, box_specification_id: o.box_specification_id) }, foreign_key: :sale_price, primary_key: :price, optional: true

      has_many :boxes, ->(o){ where(organ_id: o.organ_id, held_user_id: o.user_id) }, primary_key: :box_specification_id, foreign_key: :box_specification_id

      before_validation :init_box_sell, if: -> { sale_price.present? && sale_price_changed? }
    end

    def init_box_sell
      box_sell || build_box_sell
    end

  end
end
