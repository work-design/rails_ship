module RailsShip::Address
  extend ActiveSupport::Concern
  included do
    attribute :detail, :string

    belongs_to :area, optional: true
    belongs_to :buyer, polymorphic: true
  end


end
