module Ship
  module Model::Location
    extend ActiveSupport::Concern

    included do
      attribute :poiname, :string
      attribute :poiaddress, :string
      attribute :cityname, :string
      attribute :lat, :decimal, precision: 10, scale: 8
      attribute :lng, :decimal, precision: 11, scale: 8
      attribute :position, :integer

      belongs_to :area, optional: true
      belongs_to :line

      acts_as_list
    end

  end
end
