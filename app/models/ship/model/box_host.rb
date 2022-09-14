module Ship
  module Model::BoxHost
    extend ActiveSupport::Concern

    included do
      attribute :boxes_count, :integer, default: 0
      attribute :rented_count, :integer, default: 0
      attribute :rentable_count, :integer, default: 0

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
      self.rented_count = boxes.rented.count
      self.rentable_count = boxes.rentable.count
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
      boxes = self.boxes.orderable.limit(item.rest_number)
      if item.number > boxes.size
        item.done_number = boxes.size
      else
        item.done_number = item.number
      end

      boxes.map do |box|
        box.owned_user_id = item.user_id
        box.owned_organ_id = item.member_organ_id
        box.status = 'free'
        box
      end

      item.class.transaction do
        boxes.each(&:save!)
        item.save!
      end
    end

  end
end
