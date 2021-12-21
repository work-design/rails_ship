module Ship
  module Model::Station
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :detail, :string

      belongs_to :area

      has_many :addresses
    end

  end
end

