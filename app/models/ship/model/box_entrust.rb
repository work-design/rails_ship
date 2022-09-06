module Ship
  module Model::BoxEntrust
    extend ActiveSupport::Concern

    included do
      attribute :type, :string
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

      belongs_to :box_hold, ->(o){ where(organ_id: o.organ_id, box_specification_id: o.box_specification_id) }, primary_key: :user_id, foreign_key: :user_id
    end

    def init_box_hold
      box_hold || build_box_hold
    end

  end
end
