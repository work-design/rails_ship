module Ship
  module Model::Driver
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :number, :string
      attribute :detail, :jsonb, default: {}

      belongs_to :user, class_name: 'Auth::User'
      has_many :favorites, dependent: :delete_all
      has_many :users, through: :favorites

      has_one_attached :license

      after_create_commit :ocr_later
      after_create_commit :sync_to_favorite
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

    def sync_to_favorite
      if user.inviter_id
        favorite = favorites.build(user_id: user.inviter_id)
        favorite.save
      end
    end

  end
end
