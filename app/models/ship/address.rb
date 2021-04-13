module Ship
  class Address < ApplicationRecord
    self.table_name = 'addresses'
    include Model::Address
    include Profiled::Model::Address
  end
end
