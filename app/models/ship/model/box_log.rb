module Ship
  module Model::BoxLog
    extend ActiveSupport::Concern

    included do
      belongs_to :box
      belongs_to :package
    end

  end

end

