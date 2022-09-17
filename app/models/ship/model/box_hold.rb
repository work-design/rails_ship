module Ship
  module Model::BoxHold
    extend ActiveSupport::Concern

    included do
      attribute :boxes_count, :integer, default: 0
      attribute :rented_amount, :integer
      attribute :owned_amount, :integer
      #attribute :sellable, :integer
      #attribute :buyable, :integer

      belongs_to :box_specification
      belongs_to :organ, class_name: 'Org::Organ', optional: true

      belongs_to :user, class_name: 'Auth::User'
      belongs_to :member, class_name: 'Org::Member', optional: true
      belongs_to :member_organ, class_name: 'Org::Organ', optional: true

      belongs_to :box_host, ->(o) { where(organ_id: o.organ_id) }, foreign_key: :box_specification_id, primary_key: :box_specification_id, optional: true

      has_many :box_sells, ->(o) { where(organ_id: o.organ_id, user_id: o.user_id, member_id: o.member_id) }, primary_key: :box_specification_id, foreign_key: :box_specification_id
      has_many :box_buys, ->(o) { where(organ_id: o.organ_id, user_id: o.user_id, member_id: o.member_id) }, primary_key: :box_specification_id, foreign_key: :box_specification_id
      has_many :boxes, ->(o) { where(organ_id: o.organ_id, owned_user_id: o.user_id) }, primary_key: :box_specification_id, foreign_key: :box_specification_id
      has_many :items, ->(o) { where(member_id: o.member_id, good_type: 'Ship::BoxHost', good_id: o.box_host.id) }, class_name: 'Trade::Item', primary_key: :user_id, foreign_key: :user_id

      has_many :rents, class_name: 'Trade::Rent', through: :boxes

      before_validation :init_box_host, if: -> { organ_id.present? && organ_id_changed? }
    end

    def init_box_host
      box_host || build_box_host
    end

    def sum_owned_amount
      self.owned_amount = box_sells.sum(:amount) + items.aim_use.sum(:number)
    end

    def sum_rent_amount
      self.rent_amount = items.aim_rent.sum(:number)
    end

    def average_price
      items.average(:single_price)&.to_fs(:rounded, precision: 3)
    end

  end
end
