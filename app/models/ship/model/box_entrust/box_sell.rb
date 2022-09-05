module Ship
  module Model::BoxEntrust::BoxSell
    extend ActiveSupport::Concern

    included do
      belongs_to :box_proxy_sell, ->(o){ where(organ_id: o.organ_id, price: o.price) }, foreign_key: :box_specification_id, primary_key: :box_specification_id, optional: true

      before_validation :init_box_proxy_sell, if: -> { price.present? && (['price', 'amount'] & changes.keys).present? }
    end

    def init_box_proxy_sell
      box_proxy_sell || build_box_proxy_sell
    end

  end
end
