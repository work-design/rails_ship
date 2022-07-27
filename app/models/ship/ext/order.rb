module Ship
  module Ext::Order
    extend ActiveSupport::Concern

    included do
      has_many :packages, -> { distinct }, through: :trade_items
    end

    def package
      pack = address.packages.build(organ_id: organ_id)
      pack.from_address_id = from_address_id
      pack.user_id = user_id
      trade_items.each do |trade_item|
        p = trade_item.packageds.build
        p.package = pack
        p.save
      end
    end

  end
end
