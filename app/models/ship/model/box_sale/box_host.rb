module Ship
  module Model::BoxSale::BoxHost
    extend ActiveSupport::Concern

    included do
      has_many :box_proxy_sells, ->(o) { where(organ_id: o.organ_id) }, primary_key: :box_specification_id, foreign_key: :box_specification_id
      has_many :box_proxy_buys, ->(o) { where(organ_id: o.organ_id) }, primary_key: :box_specification_id, foreign_key: :box_specification_id
    end

  end
end