module RailsShip::Package
  extend ActiveSupport::Concern

  included do
    attribute :state, :string
    attribute :expected_on, :date
    attribute :pick_mode, :string

    belongs_to :address
    has_many :shipments, dependent: :delete_all
    has_many :packageds, dependent: :delete_all
    has_many :trade_items, through: :packageds

    enum pick_mode: {
      by_self: 'by_self',
      by_man: 'by_man'
    }

  end

end
