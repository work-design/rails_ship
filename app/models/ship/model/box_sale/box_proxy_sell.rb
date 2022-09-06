module Ship
  module Model::BoxSale::BoxProxySell
    extend ActiveSupport::Concern

    included do
      attribute :sellable_count, :integer, default: 0

      has_many :box_sells, ->(o) { default_where(organ_id: o.organ_id, 'rest-amount-gt': 0).order(id: :asc) }, primary_key: :box_specification_id, foreign_key: :box_specification_id
    end

    def order_paid(item)
      r = box_sells.pluck(:id, :rest_amount)
      last = r.find_until(number)[-1]
      box_sells.default_where('id-lte': last[0]).each do |box_sell|
        box_sell.done_amount = box_sell.amount
        box_sell.item = item
        box_sell.save
      end
    end

  end
end
