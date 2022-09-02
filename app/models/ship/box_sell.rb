module Ship
  class BoxSell < ApplicationRecord
    include Model::BoxSell
    include Trade::Ext::Good
  end
end
