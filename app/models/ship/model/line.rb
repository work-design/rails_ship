module Ship
  module Model::Line
    extend ActiveSupport::Concern

    included do
      attribute :start_name, :string
      attribute :finish_name, :string

      belongs_to :start_location, class_name: 'Location'
      belongs_to :finish_location, class_name: 'Location'

      has_many :locations

      accepts_nested_attributes_for :locations
    end

    def name

    end

  end
end
