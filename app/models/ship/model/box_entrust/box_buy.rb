module Ship
  module Model::BoxBuy
    extend ActiveSupport::Concern

    included do
      has_many :box_holds, ->(o){ where(organ_id: o.organ_id, buy_price: o.price) }, primary_key: :box_specification_id, foreign_key: :box_specification_id
    end

  end
end
