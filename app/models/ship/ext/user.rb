module Ship
  module Ext::User
    extend ActiveSupport::Concern

    included do
      has_one :driver, class_name: 'Ship::Driver'
      has_many :cars, class_name: 'Ship::Car'
    end

  end
end
