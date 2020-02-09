module RailsShip::Rally
  extend ActiveSupport::Concern
  
  included do
    attribute :name, :string

    belongs_to :area
  end

end
