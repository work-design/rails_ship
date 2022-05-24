module Ship
  module Model::BoxSpecification
    extend ActiveSupport::Concern

    included do
      attribute :boxes_count, :integer, default: 0

      has_one_attached :logo

      has_many :boxes, dependent: :nullify
    end

  end
end
