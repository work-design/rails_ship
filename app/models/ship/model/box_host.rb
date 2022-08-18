module Ship
  module Model::BoxHost
    extend ActiveSupport::Concern

    included do
      attribute :boxes_count, :integer, default: 0
      attribute :rented_count, :integer, default: 0
      attribute :rentable_count, :integer, default: 0

      belongs_to :organ, class_name: 'Org::Organ'
      belongs_to :box_specification

      has_many :boxes, ->(o){ where(organ_id: o.organ_id) }, primary_key: :box_specification_id, foreign_key: :box_specification_id
    end

  end
end
