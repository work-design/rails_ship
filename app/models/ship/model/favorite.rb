module Ship
  module Model::Favorite
    extend ActiveSupport::Concern

    included do

      belongs_to :user, class_name: 'Auth::User'

      belongs_to :driver
    end

  end
end
