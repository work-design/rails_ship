module Ship
  module Model::BoxSale::BoxProxySell
    extend ActiveSupport::Concern

    included do
      attribute :sellable_count, :integer, default: 0

      has_many :box_sells, ->(o) { where(organ_id: o.organ_id).order(id: :asc) }, primary_key: :box_specification_id, foreign_key: :box_specification_id
    end

    def order_paid(item)

    end

    def xx(number)
      r = box_sells.pluck(:id, :rest_amount)
      last = r.find_until(number)[-1]
    end

  end
end
