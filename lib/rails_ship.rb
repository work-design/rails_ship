require 'rails_ship/engine'
require 'rails_ship/config'

module Ship

  def self.use_relative_model_naming?
    true
  end

  def self.table_name_prefix
    'ship_'
  end

end
