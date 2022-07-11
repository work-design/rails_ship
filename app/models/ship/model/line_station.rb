module Ship
  module Model::LineStation
    extend ActiveSupport::Concern

    included do
      attribute :position, :integer

      belongs_to :line
      belongs_to :station

      acts_as_list scope: [:line_id]

      after_create_commit :sync_names_to_line
    end

    def sync_names_to_line
      line.sync_names_to_line
    end

  end
end
