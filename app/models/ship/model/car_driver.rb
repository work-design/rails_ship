module Ship
  module Model::CarDriver
    extend ActiveSupport::Concern

    included do
      attribute :repeat_days, :json

      enum event_type: {
        yearly: 'yearly',
        monthly: 'monthly',
        weekly: 'weekly',
        daily: 'daily'
      }

      belongs_to :car
      belongs_to :driver
    end


  end
end
