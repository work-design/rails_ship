module Ship
  module Ext::Boxing
    extend ActiveSupport::Concern

    included do
      belongs_to :box, class_name: 'Ship::Box', optional: true
    end

  end
end
