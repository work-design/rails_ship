module Ship
  module Model::Station
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :detail, :string
      attribute :poiname, :string
      attribute :poiaddress, :string
      attribute :cityname, :string
      attribute :lat, :decimal, precision: 10, scale: 8
      attribute :lng, :decimal, precision: 11, scale: 8
      attribute :coordinate, :point

      belongs_to :organ, class_name: 'Org::Organ'
      belongs_to :area, class_name: 'Profiled::Area'
      has_taxons :area

      has_many :line_stations, dependent: :destroy_async
      has_many :lines, through: :line_stations
      has_many :addresses, class_name: 'Profiled::Address'

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
      result
    end

  end
end

