module Ship
  module Model::BoxLog
    extend ActiveSupport::Concern

    included do
      attribute :boxed_in_at, :datetime
      attribute :boxed_out_at, :datetime
      attribute :duration, :integer

      belongs_to :box, counter_cache: true
      belongs_to :package

      before_validation :compute_duration, if: -> { boxed_out_at.present? && boxed_out_at_changed? }
    end

    def compute_duration
      self.duration = boxed_out_at - boxed_in_at
    end

  end

end
