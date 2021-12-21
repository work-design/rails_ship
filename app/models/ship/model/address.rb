module Ship
  module Model::Address
    extend ActiveSupport::Concern

    included do
      attribute :floor, :string, comment: '楼层'
      attribute :room, :string, comment: '房间号'

      belongs_to :station, optional: true

      has_many :packages
    end

  end
end
