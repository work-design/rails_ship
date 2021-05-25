module Ship
  class Package < ApplicationRecord
    include Model::Package
    include Wait::Ext::Waiting if defined? RailsWait
  end
end
