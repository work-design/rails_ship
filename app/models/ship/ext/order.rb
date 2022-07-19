module Ship
  module Ext::Order
    extend ActiveSupport::Concern

    included do
      has_many :packages, -> { distinct }, through: :trade_items
    end

    def package
      pack = address.packages.build(default_form_params)
      produce_plan_ids = trade_items.deliverable.pluck(:produce_plan_id).uniq

      pack.user_id = user_id
      pack.produce_plan_id = produce_plan_ids[0]
      trade_items.each do |trade_item|
        p = trade_item.packageds.build
        p.package = pack
        p.save
      end
    end

  end
end
