module Ship
  module Model::BoxSell
    extend ActiveSupport::Concern

    included do
      attribute :price, :decimal
      attribute :amount, :integer
      attribute :done_amount, :integer, default: 0
      attribute :rest_amount, :integer

      belongs_to :box_specification
      belongs_to :organ, class_name: 'Org::Organ', optional: true

      belongs_to :user, class_name: 'Auth::User'
      belongs_to :member, class_name: 'Org::Member', optional: true
      belongs_to :member_organ, class_name: 'Org::Organ', optional: true

      belongs_to :item, class_name: 'Trade::Item', optional: true

      belongs_to :box_proxy_sell, ->(o){ where(organ_id: o.organ_id, price: o.price) }, foreign_key: :box_specification_id, primary_key: :box_specification_id, optional: true
      belongs_to :box_hold, ->(o){ where(organ_id: o.organ_id, box_specification_id: o.box_specification_id) }, primary_key: :user_id, foreign_key: :user_id

      has_many :items, ->(o) { where(organ_id: o.organ_id, good_type: 'Ship::BoxSale', good_id: o.box_proxy_sell&.id, member_id: o.member_id) }, class_name: 'Trade::Item', primary_key: :user_id, foreign_key: :user_id

      before_validation :init_box_proxy_sell, if: -> { price.present? && (['price', 'amount'] & changes.keys).present? }
      before_validation :compute_rest_amount, if: -> { (['amount', 'done_amount'] & changes.keys).present? }
    end

    def init_box_hold
      box_hold || build_box_hold
    end

    def init_box_proxy_sell
      box_proxy_sell || build_box_proxy_sell
    end

    def compute_rest_amount
      self.rest_amount = self.amount - self.done_amount
    end

  end
end
