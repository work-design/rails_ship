module Ship
  module Model::Packaged
    extend ActiveSupport::Concern

    included do
      attribute :trade_item_status, :string

      belongs_to :package, inverse_of: :packageds
      belongs_to :trade_item

      before_save :sync_trade_item_status
      after_create :update_status
      after_destroy :revert_status
    end

    def sync_trade_item_status
      self.trade_item_status = trade_item.status
    end

    def update_status
      self.trade_item.update status: 'packaged'
    end

    def revert_status
      self.trade_item.update status: self.trade_item_status
    end

  end
end
