module Ship
  module Model::BoxSpecification
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :width, :integer
      attribute :length, :integer
      attribute :height, :integer
      attribute :boxes_count, :integer, default: 0
      attribute :unit, :string
      attribute :code, :string

      has_one_attached :logo
      has_many_attached :covers

      has_many :boxes, dependent: :nullify
      has_many :box_hosts
    end

    def measure
      "#{width}#{unit} * #{length}#{unit} * #{height}#{unit}"
    end

  end
end
