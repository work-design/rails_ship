module Ship
  module Model::Address
    extend ActiveSupport::Concern

    included do
      has_many :packages
    end

  end
end
