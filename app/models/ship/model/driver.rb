module Ship
  module Model::Driver
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :number, :string
      attribute :detail, :json

      belongs_to :user, class_name: 'Auth::User'

      has_one_attached :license
    end

    def ocr
      TencentHelper.license_ocr(license.url)
    end

  end
end
