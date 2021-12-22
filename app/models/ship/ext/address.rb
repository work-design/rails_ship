module Ship
  module Ext::Address
    extend ActiveSupport::Concern

    included do
      attribute :floor, :string, comment: '楼层'
      attribute :room, :string, comment: '房间号'

      belongs_to :station, class_name: 'Ship::Station', optional: true

      has_many :packages, class_name: 'Ship::Package'

      before_validation :sync_area, if: -> { station_id_changed? && station.present? }
    end

    def sync_area
      self.area_id = station.area_id
    end

  end
end
