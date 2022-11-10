module Ship
  module Model::Driver
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :number, :string
      attribute :detail, :json, default: {}

      belongs_to :organ, class_name: 'Org::Organ', optional: true
      belongs_to :user, class_name: 'Auth::User', optional: true
      belongs_to :member, class_name: 'Org::Member', optional: true

      has_many :favorites, dependent: :destroy_async
      has_many :users, through: :favorites
      has_many :car_drivers, dependent: :destroy_async
      has_many :cars, through: :car_drivers

      has_one_attached :license

      after_create_commit :ocr_later
      #after_create_commit :sync_to_favorite, if: -> { saved_change_to_user_id? }
    end

    def ocr_later
      DriverOcrJob.perform_later(self)
    end

    def ocr
      r = TencentHelper.license_ocr(license.url)
      self.name = r['Name']
      self.number = r['CardCode']
      self.detail = r
      self.save
      r
    end

    def for_update
      broadcast_action_to 'driver_edit', action: :update, target: 'driver_update', partial: 'ship/my/drivers/edit_form', locals: { driver: self }
    end

    # depend on rails wechat
    def sync_to_favorite
      user.user_inviters.map do |user_inviter|
        favorite = favorites.build(user_id: user_inviter.id)
        favorite.save
        favorite
      end
    end

  end
end
