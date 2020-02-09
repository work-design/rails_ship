module RailsShip::Rally
  extend ActiveSupport::Concern

  included do
    has_many :rally_users, dependent: :delete_all
    has_many :rallies, through: :rally_users
  end

end
