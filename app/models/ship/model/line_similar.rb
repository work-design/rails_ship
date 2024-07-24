module Ship
  module Model::LineSimilar
    extend ActiveSupport::Concern

    included do
      attribute :score, :decimal
      attribute :position, :integer

      belongs_to :line
      belongs_to :similar, class_name: 'Way', foreign_key: :similar_id

      positioned
    end

  end
end
