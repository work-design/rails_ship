# frozen_string_literal: true

module Ship
  module Ext::Member
    extend ActiveSupport::Concern

    included do
      has_many :addresses, class_name: 'Ship::Address', foreign_key: :member_id

      has_many :agent_addresses, class_name: 'Ship::Address', foreign_key: :agent_id
    end

  end
end

