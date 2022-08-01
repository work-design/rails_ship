module Ship
  module Model::ShipmentLog
    extend ActiveSupport::Concern

    included do
      attribute :expected_leave_at, :datetime
      attribute :expected_arrive_at, :datetime
      attribute :left_at, :datetime
      attribute :arrived_at, :datetime

      belongs_to :shipment
      belongs_to :line_station
    end

  end
end

