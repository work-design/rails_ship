module Ship
  module Model::Way
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :start_name, :string
      attribute :finish_name, :string
      attribute :locations_count, :integer, default: 0

      belongs_to :organ, class_name: 'Org::Organ', optional: true
      belongs_to :user, class_name: 'Auth::User'

      belongs_to :line, optional: true

      has_many :locations, -> { order(position: :asc) }, dependent: :destroy_async
      accepts_nested_attributes_for :locations
      has_many :line_similars, foreign_key: :similar_id, dependent: :delete_all
      has_many :similars, through: :line_similars
    end

    def sync_names_from_locations
      self.start_name = locations[0].name
      self.finish_name = locations[-1].name
      self.save
    end

  end
end
