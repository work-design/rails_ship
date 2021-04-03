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

      belongs_to :area, optional: true
      belongs_to :line, counter_cache: true

      acts_as_list scope: [:line_id]
    end

    def position_text
      if line.new_record?
        count = line.locations.size
      else
        count = line.locations_count
      end

      if count == position
        '终点'
      elsif position == 1
        '起点'
      else
        "途经点#{position}"
      end
    end

  end
end
