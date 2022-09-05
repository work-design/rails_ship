module Ship
  class BoxHost < ApplicationRecord
    include Model::BoxHost
    include Trade::Ext::Good
  end
end
