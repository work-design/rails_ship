module Ship
  class TradeItem < ApplicationRecord
    include Trade::Model::TradeItem
    include Model::TradeItem
  end
end
