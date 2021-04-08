module Ship
  module Model::Line
    extend ActiveSupport::Concern

    included do
      attribute :start_name, :string
      attribute :finish_name, :string
      attribute :locations_count, :integer, default: 0

      belongs_to :user, class_name: 'Auth::User'

      has_many :locations, -> { order(position: :asc) }, dependent: :delete_all, inverse_of: :line
      accepts_nested_attributes_for :locations

      after_create_commit :sync_names
    end

    def sync_names
      self.start_name = locations[0].poiname
      self.finish_name = locations[1].poiname
      self.save
    end

  end
end
