module Ship
  module Model::UserLine
    extend ActiveSupport::Concern

    included do
      belongs_to :line
      belongs_to :user, class_name: 'Auth::User', optional: true
    end

  end
end