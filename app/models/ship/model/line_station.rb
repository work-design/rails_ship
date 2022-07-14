module Ship
  module Model::LineStation
    extend ActiveSupport::Concern

    included do
      attribute :position, :integer

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      belongs_to :line, counter_cache: true
      belongs_to :station

      acts_as_list scope: [:line_id]

      before_validation :sync_organ, if: -> { station_id_changed? }
      after_create_commit :sync_names_to_line
    end

    def sync_organ
      self.organ_id = station.organ_id
    end

    def sync_names_to_line
      line.sync_names_to_line
    end

  end
end
