module RailsShip::Packaged
  extend ActiveSupport::Concern

  included do
    belongs_to :package, inverse_of: :packageds
    belongs_to :trade_item

    after_create :update_status
    after_destroy :revert_status
  end

  def update_status
    self.trade_item.update status: 'packaged'
  end

  def revert_status
    self.trade_item.update status: 'paid'
  end

end
