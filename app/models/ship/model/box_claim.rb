module Ship
  module Model::Claim
    extend ActiveSupport::Concern

    included do

      belongs_to :user, class_name: 'Auth::User', optional: true
    end


  end
end
