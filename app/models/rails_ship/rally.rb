module RailsShip::Rally
  extend ActiveSupport::Concern

  included do
    attribute :name, :string
    attribute :detail, :string

    belongs_to :area
    has_many :rally_users, dependent: :delete_all
    has_many :users, through: :users
  end

end