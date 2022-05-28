module Ship
  module Model::Car
    extend ActiveSupport::Concern

    included do
      attribute :brand, :string, comment: '车品牌'
      attribute :location, :string
      attribute :number, :string, comment: '车牌号'
      attribute :detail, :json

      enum kind: {
        freight: 'freight',
        passenger: 'passenger'
      }

      belongs_to :user, class_name: 'Auth::User'

      has_many :car_drivers, dependent: :destroy_async
      has_many :drivers, through: :car_drivers

      has_one_attached :registration

      after_create_commit :ocr_later
    end

    def ocr_later
      CarOcrJob.perform_later(self)
    end

    def ocr
      r = TencentHelper.registration_ocr(registration.url)
      self.detail = r['FrontInfo']
      self.number = detail['PlateNo'] if detail.is_a?(Hash)
      self.save
      r
    end

    def for_update
      broadcast_action_to 'car_new', action: :update, target: 'car_update', partial: 'ship/my/cars/edit_form', locals: { car: self }
    end

  end
end
