module RailsShip::Packaged
  extend ActiveSupport::Concern

  included do
    belongs_to :package, inverse_of: :packageds
    belongs_to :trade_item

    after_create :xx
  end

  def xx
    self.trade_item.update status: 'packaged'
  end

end
