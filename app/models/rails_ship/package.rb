module RailsShip::Package
  extend ActiveSupport::Concern

  included do
    attribute :state, :string

    belongs_to :shipment, optional: true
    has_many :packageds, dependent: :delete_all
    has_many :trade_items, through: :packageds
  end

end
