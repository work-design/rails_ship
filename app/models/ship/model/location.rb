module Ship
  module Model::Location
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :position, :integer
      attribute :poiname, :string
      attribute :poiaddress, :string
      attribute :cityname, :string
      attribute :lat, :decimal, precision: 10, scale: 8
      attribute :lng, :decimal, precision: 11, scale: 8
      attribute :coordinate, :point

      belongs_to :organ, class_name: 'Org::Organ', optional: true
      belongs_to :area, class_name: 'Profiled::Area', optional: true
      has_taxons :area

      belongs_to :way, counter_cache: true
      belongs_to :station, optional: true

      acts_as_list scope: [:line_id]

      before_validation :sync_organ, if: -> { station_id_changed? }
      after_save_commit :sync_names_to_line, if: -> { saved_change_to_position? }
    end

    def position_text
      if way.new_record?
        count = way.locations.size
      else
        count = way.locations_count
      end

      if position.to_i == 0
        '起点'
      elsif position.to_i >= count
        '终点'
      else
        "途经点#{position}"
      end
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
