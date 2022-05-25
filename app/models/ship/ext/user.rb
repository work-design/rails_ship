module Ship
  module Ext::User
    extend ActiveSupport::Concern

    included do
      has_one :driver, class_name: 'Ship::Driver'
      has_many :cars, class_name: 'Ship::Car'
      has_many :user_lines, class_name: 'Ship::UserLine', dependent: :destroy_async
      has_many :lines, through: :user_lines

      has_many :favorites, class_name: 'Ship::Favorite'
      has_many :drivers, class_name: 'Ship::Driver', through: :favorites
    end

  end
end
