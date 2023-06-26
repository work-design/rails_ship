module Ship
  module Model::BoxHold
    extend ActiveSupport::Concern

    included do
      attribute :boxes_count, :integer, default: 0
      attribute :rented_amount, :integer, default: 0
      attribute :owned_amount, :integer, default: 0
      attribute :box_host_id, :integer

      belongs_to :box_specification
      belongs_to :organ, class_name: 'Org::Organ', optional: true

      belongs_to :user, class_name: 'Auth::User'
      belongs_to :member, class_name: 'Org::Member', optional: true
      belongs_to :member_organ, class_name: 'Org::Organ', optional: true

      belongs_to :box_host, ->(o) { where(organ_id: o.organ_id) }, foreign_key: :box_specification_id, primary_key: :box_specification_id, optional: true

      has_many :box_sells, ->(o) { where(organ_id: o.organ_id, user_id: o.user_id, member_id: o.member_id) }, primary_key: :box_specification_id, foreign_key: :box_specification_id
      has_many :box_buys, ->(o) { where(organ_id: o.organ_id, user_id: o.user_id, member_id: o.member_id) }, primary_key: :box_specification_id, foreign_key: :box_specification_id
      has_many :boxes, ->(o) { where(organ_id: o.organ_id, held_user_id: o.user_id) }, primary_key: :box_specification_id, foreign_key: :box_specification_id
      has_many :items, ->(o) { where(member_id: o.member_id, good_type: 'Ship::BoxHost', good_id: o.box_host.id) }, class_name: 'Trade::Item', primary_key: :user_id, foreign_key: :user_id

      has_many :rents, class_name: 'Trade::Rent', through: :boxes

      before_validation :init_box_host, if: -> { organ_id.present? && organ_id_changed? }
    end

    def init_box_host
      box_host || build_box_host
    end

    def reset_boxes_count
      self.boxes_count = boxes.count
      self.sum_owned_amount
      self.sum_rented_amount
      self.changes
    end

    def total_amount
      owned_amount + rented_amount - boxes_count
    end

    def sum_owned_amount
      self.owned_amount = box_sells.sum(:rest_amount) + items.aim_use.deliverable.sum(:done_number)
    end

    def sum_rented_amount
      self.rented_amount = items.aim_rent.deliverable.sum(:done_number)
    end

    def do_rent(box, item)
      box.do_rent(item)
      box.rented = false if owned_amount > 0  # 优先扣除购买的额度
    end

    def average_price
      items.average(:single_price)&.to_fs(:rounded, precision: 3)
    end

  end
end
