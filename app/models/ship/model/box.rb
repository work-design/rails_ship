module Ship
  module Model::Box
    extend ActiveSupport::Concern

    included do
      attribute :code
      attribute :loaded_at, :datetime
      attribute :unloaded_at, :datetime

      enum status: {
        free: 'free',
        hired: 'hired',
        used: 'used'
      }, _prefix: true
      enum state: {
        grid_in: 'grid_in',
        grid_out: 'grid_out',
        loaded: 'loaded',
        unloaded: 'unloaded'
      }, _prefix: true

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      belongs_to :box_specification, counter_cache: true

      has_many :packages, dependent: :nullify
    end

    def price
    end

    def enter_url
      Rails.application.routes.url_for(controller: 'ship/me/boxes', action: 'qrcode', id: self.id)
    end

    def qrcode_enter_url
      QrcodeHelper.data_url(enter_url)
    end

  end
end
