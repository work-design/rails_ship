module Ship
  module Model::Location
    extend ActiveSupport::Concern

    included do
      attribute :poiname, :string
      attribute :poiaddress, :string
      attribute :cityname, :string
      attribute :lat, :decimal, precision: 10, scale: 8
      attribute :lng, :decimal, precision: 11, scale: 8
      attribute :position, :integer

      belongs_to :area, class_name: 'Profiled::Area', optional: true
      belongs_to :line, counter_cache: true

      acts_as_list scope: [:line_id]

      after_save_commit :geo_later, if: -> { saved_change_to_lat? || saved_change_to_lng? }
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
    end

  end
end
