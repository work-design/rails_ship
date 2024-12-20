module Ship
  class Address < ApplicationRecord
    include Model::Address
    include Factory::Ext::Address if defined? RailsFactory
    include Ship::Ext::Address if defined? RailsShip
    include Wait::Model::Address if defined? RailsWait
    include Crm::Ext::Maintainable if defined? RailsCrm
  end
end
