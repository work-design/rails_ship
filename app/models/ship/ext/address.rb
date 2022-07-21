module Ship
  module Ext::Address
    extend ActiveSupport::Concern

    included do
      attribute :floor, :string, comment: '楼层'
      attribute :room, :string, comment: '房间号'

      belongs_to :station, class_name: 'Ship::Station', optional: true

      has_many :packages, class_name: 'Ship::Package'
      has_many :shipments, as: :shipping

      before_validation :sync_area, if: -> { station_id_changed? && station.present? }
      after_save :sync_station_id, if: -> { station_id.present? && saved_change_to_station_id? }
    end

    def sync_area
      self.area_id = station.area_id
    end

    def sync_station_id
      packages.where(station_id: nil).update_all(station_id: station_id)
    end

  end
end
