module Ship
  module Ext::User
    extend ActiveSupport::Concern

    included do
      has_one :driver, class_name: 'Ship::Driver'
      has_many :cars, class_name: 'Ship::Car'
      has_many :lines, class_name: 'Ship::Line'

      has_many :favorites, class_name: 'Ship::Favorite'
      has_many :drivers, class_name: 'Ship::Driver', through: :favorites
    end

  end
end
