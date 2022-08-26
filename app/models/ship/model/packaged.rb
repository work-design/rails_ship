module Ship
  module Model::Packaged
    extend ActiveSupport::Concern

    included do
      attribute :trade_item_status, :string

      belongs_to :trade_item, class_name: 'Trade::Item'
      belongs_to :production_item, class_name: 'Factory::ProductionItem', optional: true
      belongs_to :package, inverse_of: :packageds, counter_cache: true

      after_create :update_status
      after_save :sync_trade_item_status, if: -> { saved_change_to_trade_item_id? }
      after_destroy :revert_status
    end

    def update_status
      self.trade_item.update status: 'packaged'
    end

    def sync_trade_item_status
      self.trade_item_status = trade_item.status
      self.save
    end

    def revert_status
      self.trade_item.update status: self.trade_item_status
    end

  end
end
