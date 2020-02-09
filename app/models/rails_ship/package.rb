module RailsShip::Package
  extend ActiveSupport::Concern
  included do

    has_many :package_items, dependent: :delete_all
  end

end
