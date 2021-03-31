module Ship
  module Model::Car
    extend ActiveSupport::Concern

    included do
      attribute :location, :string
      attribute :number, :string
      attribute :detail, :json

      belongs_to :user, class_name: 'Auth::User'

      has_one_attached :registration

      after_create_commit :ocr_later
    end

    def ocr_later
      CarOcrJob.perform_later(self)
    end

    def ocr
      r = TencentHelper.registration_ocr(registration.url)
      self.detail = r['FrontInfo']
      self.number = detail['PlateNo']
      self.save
    end

  end
end
