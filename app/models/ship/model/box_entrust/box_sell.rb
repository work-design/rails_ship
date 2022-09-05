module Ship
  module Model::BoxSell
    extend ActiveSupport::Concern

    included do
      before_validation :init_box_sell, if: -> { sell_price.present? && (['sell_price', 'sellable'] & changes.keys).present? }

    end

    def init_box_sell
      box_sell || build_box_sell
    end

  end
end
