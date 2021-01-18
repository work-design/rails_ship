module Ship
  class Package < ApplicationRecord
    include Model::Package
    include Wait::Model::Waiting if defined? RailsWait
  end
end
