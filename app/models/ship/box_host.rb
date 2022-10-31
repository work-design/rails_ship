module Ship
  class BoxHost < ApplicationRecord
    include Model::BoxHost
    include Trade::Ext::Rentable
    include Trade::Ext::Good
  end
end
