module Ship
  module Model::Line
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :start_name, :string
      attribute :finish_name, :string
      attribute :line_stations_count, :integer, default: 0

      has_many :line_stations, -> { includes(:station) }, dependent: :destroy_async
      has_many :stations, -> { order(position: :asc) }, through: :line_stations, inverse_of: :lines
      accepts_nested_attributes_for :stations
      has_many :line_similars, dependent: :delete_all
      has_many :similars, through: :line_similars

      before_validation :set_name, if: -> { start_name_changed? || finish_name_changed? }
    end

    def set_name
      self.name = [start_name.to_s, finish_name.to_s].join('-')
    end

    def sync_names_to_line
      self.start_name = line_stations[0].station.name
      self.finish_name = line_stations[-1].station.name
      self.save
    end

  end
end
