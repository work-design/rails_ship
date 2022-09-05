module Ship
  class BoxSale < ApplicationRecord
    include Model::BoxSale
    include Trade::Ext::Good
  end
end
