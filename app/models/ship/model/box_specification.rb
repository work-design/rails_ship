module Ship
  module Model::BoxSpecification
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :width, :integer
      attribute :length, :integer
      attribute :height, :integer
      attribute :boxes_count, :integer, default: 0

      has_one_attached :logo

      has_many :boxes, dependent: :nullify
    end

  end
end
