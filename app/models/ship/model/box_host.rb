module Ship
  module Model::BoxHost
    extend ActiveSupport::Concern

    included do
      attribute :boxes_count, :integer, default: 0
      attribute :tradable_count, :integer, default: 0, comment: '可交易数量，可租亦可卖'
      attribute :traded_count, :integer, as: 'boxes_count - tradable_count', virtual: true

      belongs_to :organ, class_name: 'Org::Organ'
      belongs_to :box_specification

      has_many :boxes, ->(o) { where(organ_id: o.organ_id) }, primary_key: :box_specification_id, foreign_key: :box_specification_id
      has_many :box_holds, ->(o) { where(organ_id: o.organ_id) }, primary_key: :box_specification_id, foreign_key: :box_specification_id
      has_many :box_proxy_sells, ->(o) { where(organ_id: o.organ_id) }, primary_key: :box_specification_id, foreign_key: :box_specification_id
      has_many :box_proxy_buys, ->(o) { where(organ_id: o.organ_id) }, primary_key: :box_specification_id, foreign_key: :box_specification_id
      has_many :box_sells, ->(o) { where(organ_id: o.organ_id) }, primary_key: :box_specification_id, foreign_key: :box_specification_id
    end

    def reset_boxes_count
      self.boxes_count = boxes.count
      self.tradable_count = boxes.tradable.count
    end

    # todo 针对交易量过大时候的优化
    def order_paid(item)
      # 排序：出价低的优先，先发布的优先；
      r = box_sells.default_where('rest_amount-gt': 0, 'price-lte': item.single_price).order(price: :asc, id: :asc).pluck(:id, :rest_amount)
      usable = r.find_until(item.rest_number)
      if usable.blank?
        own_item(item)
        return
      end

      b_sells = box_sells.find usable.map(&:first)
      r = b_sells[0..-2].map do |box_sell|
        box_sell.delivery(item, box_sell.rest_amount)
      end

      last_sell = b_sells[-1]
      if item.done_number + last_sell.rest_amount > item.rest_number
        last_sell.delivery(item, item.number - item.done_number)
      else
        last_sell.delivery(item, last_sell.rest_amount)
      end
      r << last_sell

      self.class.transaction do
        r.map(&:save!)
        item.save!
      end
    end

    def own_item(item)
      box_hold = get_hold(item)

      if item.aim == 'rent'
        box_hold.rented_amount += item.rest_number
      else
        box_hold.owned_amount += item.rest_number
      end

      item.done_number = item.rest_number

      item.class.transaction do
        box_hold.save!
        item.save!
      end
    end

    def get_hold(item)
      box_holds.find_by(user_id: item.user_id, member_id: item.member_id)
    end

  end
end
