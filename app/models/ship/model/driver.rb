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
      r = TencentHelper.license_ocr(license.url)
      self.name = r['Name']
      self.number = r['CardCode']
      self.detail = r
      self.save
    end

    def for_update
      broadcast_action_to 'driver_edit', action: :update, target: 'driver_update', partial: 'ship/my/drivers/edit_form', locals: { driver: self }
    end

  end
end
