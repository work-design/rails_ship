module Ship
  module Model::Driver
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :number, :string

      # 依赖微信
      attribute :media_id, :string

      # 依赖 RailsAuth
      belongs_to :user, class_name: 'Auth::User'

      has_one_attached :license
    end

  end
end
