module Ship
  module Ext::TradeItem
    extend ActiveSupport::Concern

    included do
      has_many :packageds, class_name: 'Ship::Packaged', dependent: :destroy_async
      has_many :packages, class_name: 'Ship::Package', through: :packageds
    end

  end
end
