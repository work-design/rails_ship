module Ship
  module Model::Package
    extend ActiveSupport::Concern

    included do
      attribute :state, :string
      attribute :expected_on, :date
      attribute :pick_mode, :string

      belongs_to :address, class_name: 'Profiled::Address'
      belongs_to :user, class_name: 'Auth::User', optional: true
      belongs_to :produce_plan, class_name: 'Factory::ProducePlan', optional: true if defined? RailsFactory

      has_many :shipments, dependent: :delete_all
      has_many :packageds, dependent: :destroy
      has_many :trade_items, class_name: 'Trade::TradeItem', through: :packageds

      enum pick_mode: {
        by_self: 'by_self',
        by_man: 'by_man'
      }
      enum state: {

      }
    end

    def enter_url
      Rails.application.routes.url_for(controller: 'ship/me/packages', action: 'show', id: self.id)
    end

    def qrcode_enter_url
      QrcodeHelper.data_url(enter_url)
    end

  end
end
