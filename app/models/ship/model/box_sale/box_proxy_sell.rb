module Ship
  module Model::BoxSale::BoxProxySell
    extend ActiveSupport::Concern

    included do
      attribute :sellable_count, :integer, default: 0

      has_many :box_sells, ->(o) { default_where(organ_id: o.organ_id, 'rest-amount-gt': 0).order(id: :asc) }, primary_key: :box_specification_id, foreign_key: :box_specification_id
    end

    # todo 针对交易量过大时候的优化
    def order_paid(item)
      r = box_sells.pluck(:id, :rest_amount)
      usable = r.find_until(item.number)
      b_sells = box_sells.default_where('id-lte': usable[-1][0])
      r = b_sells[0..-2].map do |box_sell|
        box_sell.item = item
        box_sell.done_amount = box_sell.amount
        item.done_number += done_amount
        box_sell
      end

      last_sell = b_sells[-1]
      last_sell.item = item
      if item.done_number + last_sell.amount > item.number
        last_sell.done_amount = item.number - item.done_number
      else
        last_sell
      end
      r << last_sell

      self.class.transaction do
        r.map(&:save)
        item.save
      end
    end

  end
end
