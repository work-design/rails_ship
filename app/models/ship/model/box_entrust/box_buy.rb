module Ship
  module Model::BoxBuy
    extend ActiveSupport::Concern

    included do
      has_many :box_holds, ->(o){ where(organ_id: o.organ_id, buy_price: o.price) }, primary_key: :box_specification_id, foreign_key: :box_specification_id

      before_validation :init_box_buy, if: -> { buy_price.present? && (['buy_price', 'buyable'] & changes.keys).present? }
    end

    def init_box_buy
      box_buy || build_box_buy
    end

  end
end
