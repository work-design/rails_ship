module Ship
  module Ext::User
    extend ActiveSupport::Concern

    included do
      has_one :driver, class_name: 'Ship::Driver'
    end

  end
end
