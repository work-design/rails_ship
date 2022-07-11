module Ship
  module Model::Line
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :start_name, :string
      attribute :finish_name, :string
      attribute :locations_count, :integer, default: 0

      has_many :line_stations, dependent: :destroy_async
      has_many :stations, -> { order(position: :asc) }, through: :line_stations, inverse_of: :line
      accepts_nested_attributes_for :stations
      has_many :line_similars, dependent: :delete_all
      has_many :similars, through: :line_similars

      before_validation :set_name, if: -> { start_name_changed? || finish_name_changed? }
    end

    def set_name
      self.name = [start_name.to_s, finish_name.to_s].join('-')
    end

  end
end
