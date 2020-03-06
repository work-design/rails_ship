module RailsShip::Address
  extend ActiveSupport::Concern
  included do
    has_many :packages
  end

end

