module Ship
  module Model::LineStation
    extend ActiveSupport::Concern

    included do
      belongs_to :line
      belongs_to :station
    end

  end
end
