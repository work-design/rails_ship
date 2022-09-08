module Ship
  class BoxHost < ApplicationRecord
    include Trade::Ext::Good
    include Model::BoxHost
  end
end
