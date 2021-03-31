module Ship
  module Model::Car
    extend ActiveSupport::Concern

    included do
      attribute :location, :string
      attribute :number, :string
      attribute :detail, :json

      belongs_to :user, class_name: 'Auth::User'

      has_one_attached :registration
    end

    def ocr
      TencentHelper.registration_ocr(registration.url)
    end

  end
end
