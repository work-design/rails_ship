module Ship
  module Model::Driver
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :code, :string

      belongs_to :user, class_name: 'Auth::User'

      has_one_attached :license
    end

  end
end
