module RailsShip::Shipment
  extend ActiveSupport::Concern

  included do
    attribute :state, :string

    belongs_to :package
    belongs_to :address
    belongs_to :shipping, polymorphic: true

    enum state: {
      prepare: 'prepare',
      packing: 'packing',
      transporting: 'transporting',
      dispatching: 'dispatching',
      received: 'received'
    }
  end

  def xx

  end

end
