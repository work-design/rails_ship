module Ship
  module Model::Location
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :poiname, :string
      attribute :poiaddress, :string
      attribute :cityname, :string
      attribute :lat, :decimal, precision: 10, scale: 8
      attribute :lng, :decimal, precision: 11, scale: 8
      attribute :position, :integer
      attribute :coordinate, :point

      belongs_to :area, class_name: 'Profiled::Area', optional: true

      belongs_to :line, counter_cache: true

      acts_as_list scope: [:line_id]

      after_save_commit :geo_later, if: -> { saved_change_to_lat? || saved_change_to_lng? }
      #after_create_commit :sync_names_to_line
    end

    def sync_names_to_line
      self.start_name = locations[0].poiname
      self.finish_name = locations[1].poiname
      self.save
    end

    def position_text
      if line.new_record?
        count = line.locations.size
      else
        count = line.locations_count
      end

      if position == 1
        '起点'
      elsif position >= count
        '终点'
      else
        "途经点#{position}"
      end
    end

    def geo_later
      LocationGeoJob.perform_later(self)
    end

    # todo 依赖 rails profiled
    def geo
      result = QqMapHelper.geocoder(lat: lat, lng: lng)
      r = result['address_component']
      area = Profiled::Area.sure_find [r['province'], r['city'], r['district']]
      self.area = area
      self.save
      result
    end

  end
end
