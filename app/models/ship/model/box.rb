module Ship
  module Model::Box
    extend ActiveSupport::Concern

    included do
      enum status: {
        free: 'free',
        hired: 'hired',
        used: 'used'
      }

      belongs_to :box_specification, counter_cache: true
    end

    def price

    end

  end
end
