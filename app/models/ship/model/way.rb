module Ship
  module Model::Way
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :start_name, :string
      attribute :finish_name, :string
      attribute :line_stations_count, :integer, default: 0

      belongs_to :line
      belongs_to :user, class_name: 'Auth::User', optional: true

      has_many :locations, -> { order(position: :asc) }, dependent: :destroy_async
      accepts_nested_attributes_for :locations
    end

  end
end
