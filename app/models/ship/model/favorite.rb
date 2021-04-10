module Ship
  module Model::Favorite
    extend ActiveSupport::Concern

    included do
      attribute :remark, :string

      belongs_to :user, class_name: 'Auth::User'

      belongs_to :driver
    end

  end
end
