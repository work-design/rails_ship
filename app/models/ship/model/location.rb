module Ship
  module Model::Location
    extend ActiveSupport::Concern

    included do
      belongs_to :name

      belongs_to :line
    end

  end
end
