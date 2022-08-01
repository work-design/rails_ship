module Ship
  module Model::LineStation
    extend ActiveSupport::Concern

    included do
      attribute :position, :integer
      attribute :expected_minutes, :integer, comment: '预计到下站分钟数'

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      belongs_to :line, counter_cache: true
      belongs_to :station

      acts_as_list scope: [:line_id]

      before_validation :sync_organ, if: -> { station_id_changed? }
      after_save_commit :sync_names_to_line, if: -> { saved_change_to_position? }
    end

    def sync_organ
      self.organ_id = station.organ_id
    end

    def sync_names_to_line
      line.sync_names_to_line
    end

    def next_item
      line.line_stations.find(&->(i){ i.position > position }) || line.line_stations.find(&->(i){ i.position == position })
    end

    def prev_item
      line.line_stations.find(&->(i){ i.position < position }) || line.line_stations.find(&->(i){ i.position == position })
    end

  end
end
