module Ship
  module Model::BoxSell
    extend ActiveSupport::Concern

    included do
      attribute :sellable_count, :integer, default: 0

      belongs_to :box_specification
      belongs_to :organ, class_name: 'Org::Organ', optional: true

      has_many :box_holds, ->(o){ where(organ_id: o.organ_id, sell_price: o.price) }, primary_key: :box_specification_id, foreign_key: :box_specification_id
    end

  end
end
