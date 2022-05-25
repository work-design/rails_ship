module Ship
  module Model::Line
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :start_name, :string
      attribute :finish_name, :string
      attribute :locations_count, :integer, default: 0

      has_many :locations, -> { order(position: :asc) }, dependent: :delete_all, inverse_of: :line
      accepts_nested_attributes_for :locations
      has_many :line_similars, dependent: :delete_all
      has_many :similars, through: :line_similars

      before_validation :set_name, if: -> { name.blank? && (start_name_changed? || finish_name_changed?) }
    end

    def set_name
      self.name = [start_name.to_s, finish_name.to_s].join('-')
    end

  end
end
