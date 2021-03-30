module Ship
  module Model::Car
    extend ActiveSupport::Concern

    included do
      attribute :location, :string
      attribute :number, :string

      belongs_to :user, class_name: 'Auth::User'

      has_one_attached :registration
    end

  end
end
