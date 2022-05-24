module Ship
  module Model::Box
    extend ActiveSupport::Concern

    included do
      attribute :code

      enum status: {
        free: 'free',
        hired: 'hired',
        used: 'used'
      }

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      belongs_to :box_specification, counter_cache: true
    end

    def price

    end

  end
end
