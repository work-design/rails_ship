module Ship
  module Ext::Order
    extend ActiveSupport::Concern

    included do
      has_many :packages, -> { distinct }, through: :trade_items
    end

  end
end
