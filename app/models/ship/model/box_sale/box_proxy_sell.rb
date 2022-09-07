module Ship
  module Model::BoxSale::BoxProxySell
    extend ActiveSupport::Concern

    included do
      attribute :sellable_count, :integer, default: 0

      has_many :box_sells, ->(o) { where(organ_id: o.organ_id) }, primary_key: :box_specification_id, foreign_key: :box_specification_id
    end

    # todo 针对交易量过大时候的优化
    def order_paid(item)
      # 排序：出价低的优先，先发布的优先；
      r = box_sells.default_where('rest-amount-gt': 0, 'price-lte': o.price).order(price: :asc, id: :asc).pluck(:id, :rest_amount)
      usable = r.find_until(item.rest_number)

      b_sells = box_sells.find(usable)
      r = b_sells[0..-2].map do |box_sell|
        box_sell.deliver(item, box_sell.rest_amount)
      end

      last_sell = b_sells[-1]
      if item.done_number + last_sell.rest_amount > item.number
        box_sell.deliver(item, item.number - item.done_number)
      else
        box_sell.deliver(item, last_sell.rest_amount)
      end
      r << last_sell

      self.class.transaction do
        r.map(&:save!)
        item.save!
      end
    end

  end
end
