module Ship
  module Model::BoxSale
    extend ActiveSupport::Concern

    included do
      attribute :type, :string
      attribute :boxes_count, :integer, default: 0
      attribute :rented_count, :integer, default: 0
      attribute :rentable_count, :integer, default: 0

      belongs_to :organ, class_name: 'Org::Organ'
      belongs_to :box_specification

      has_many :boxes, ->(o) { where(organ_id: o.organ_id) }, primary_key: :box_specification_id, foreign_key: :box_specification_id
      has_many :box_holds, ->(o) { where(organ_id: o.organ_id) }, primary_key: :box_specification_id, foreign_key: :box_specification_id
      has_many :box_proxy_sells, ->(o) { where(organ_id: o.organ_id) }, primary_key: :box_specification_id, foreign_key: :box_specification_id
      has_many :box_proxy_buys, ->(o) { where(organ_id: o.organ_id) }, primary_key: :box_specification_id, foreign_key: :box_specification_id
    end

    def reset_boxes_count
      self.boxes_count = boxes.count
      self.rented_count = boxes.rented.count
      self.rentable_count = boxes.rentable.count
    end

  end
end
