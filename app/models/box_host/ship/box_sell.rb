module Ship
  class BoxSell < BoxHost
    include Model::BoxHost::BoxSell
    include Trade::Ext::Good
  end
end
