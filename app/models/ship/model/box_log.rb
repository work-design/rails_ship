module Ship
  module Model::BoxLog
    extend ActiveSupport::Concern

    included do
      attribute :boxed_in_at, :datetime
      attribute :boxed_out_at, :datetime
      attribute :duration, :integer

      enum confirm_mode: {
        button: 'button',
        scan: 'scan',
        batch: 'batch'
      }, _prefix: true

      belongs_to :box, counter_cache: true
      belongs_to :boxed, polymorphic: true

      scope :current, -> { where(boxed_out_at: nil).order(boxed_in_at: :desc) }

      before_validation :compute_duration, if: -> { boxed_out_at.present? && boxed_out_at_changed? }
      after_save :sync_to_package, if: -> { (saved_changes.keys & ['boxed_in_at', 'boxed_out_at']).present? && boxed_type == 'Ship::Package' }
    end

    def compute_duration
      self.duration = boxed_out_at - boxed_in_at
    end

    def sync_to_package
      if boxed_out_at.present?
        boxed.box_id = nil
      else
        boxed.box_id = box_id
      end
      boxed.boxed_in_at = boxed_in_at
      boxed.boxed_out_at = boxed_out_at
      boxed.confirm_mode = confirm_mode
      boxed.save
    end

    def duration_obj
      if duration
        ActiveSupport::Duration.build(duration)
      else
        ActiveSupport::Duration.build(0)
      end
    end

  end

end
