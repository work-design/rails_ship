module Ship
  class BoxHold < ApplicationRecord
    include Model::BoxHold
    include Trade::Ext::Good
  end
end
