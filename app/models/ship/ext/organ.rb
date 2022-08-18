module Ship
  module Ext::Organ
    extend ActiveSupport::Concern

    included do
      has_many :boxes, class_name: 'Ship::Box', foreign_key: :held_organ_id
      has_many :box_hosts, class_name: 'Ship::BoxHost'
      has_many :stations, class_name: 'Ship::Station'
    end

  end
end
