module Ship
  module Ext::Item
    extend ActiveSupport::Concern

    included do
      has_many :packageds, class_name: 'Ship::Packaged', foreign_key: :trade_item_id, dependent: :destroy_async
      has_many :packages, class_name: 'Ship::Package', through: :packageds
    end

  end
end
