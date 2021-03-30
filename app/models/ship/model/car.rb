module Ship
  module Model::Car
    extend ActiveSupport::Concern

    included do
      attribute :license_location, :string
      attribute :license_number, :string

      has_one_attached :registration
    end

  end
end
