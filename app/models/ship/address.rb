module Ship
  class Address < ApplicationRecord
    self.table_name = 'profiled_addresses'
    include Model::Address
    include Profiled::Model::Address
  end
end
