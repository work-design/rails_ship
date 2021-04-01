module Ship
  module Model::Driver
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :number, :string
      attribute :detail, :json

      belongs_to :user, class_name: 'Auth::User'

      has_one_attached :license

      after_create_commit :ocr_later
    end

    def ocr_later
      DriverOcrJob.perform_later(self)
      for_update
    end

    def ocr
      TencentHelper.license_ocr(license.url)
    end

    def for_update
      broadcast_action_to 'car_new', action: :update, target: 'car_update', partial: 'ship/my/drivers/edit_form', locals: { driver: self }
    end

  end
end
