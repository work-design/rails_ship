module Ship
  module Model::BoxHold
    extend ActiveSupport::Concern

    included do
      attribute :boxes_count, :integer, default: 0

      belongs_to :box_specification

      belongs_to :user, class_name: 'Auth::User'
      belongs_to :member, class_name: 'Org::Member', optional: true
      belongs_to :organ, class_name: 'Org::Organ', optional: true

      has_many :boxes, ->(o){ where(user_id: o.user_id, member_id: o.member_id, organ_id: o.organ_id) }, primary_key: :box_specification_id, foreign_key: :box_specification_id
    end

  end
end
