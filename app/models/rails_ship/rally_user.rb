module RailsShip::RallyUser
  extend ActiveSupport::Concern

  included do
    attribute :commission_ratio, :decimal, precision: 4, scale: 2, default: 0, comment: '佣金比例'
    attribute :kind, :string

    belongs_to :rally, inverse_of: :rally_users
    belongs_to :user
    belongs_to :inviter, class_name: 'User', optional: true

    enum kind: {

    }
  end

end
