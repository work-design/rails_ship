module Ship
  module Model::ShipmentLog
    extend ActiveSupport::Concern

    included do
      attribute :expected_leave_at, :datetime
      attribute :left_at, :datetime
      attribute :arrived_at, :datetime
      attribute :prepared_at, :datetime

      belongs_to :shipment
      belongs_to :line_station
    end

    def expected_arrive_at
      (arrived_at || expected_leave_at) + shipment.expected_minutes
    end

  end
end

