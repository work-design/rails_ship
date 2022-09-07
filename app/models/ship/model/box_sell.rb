module Ship
  module Model::BoxSell
    extend ActiveSupport::Concern

    included do
      attribute :price, :decimal
      attribute :amount, :integer
      attribute :pending_amount, :integer, default: 0
      attribute :rest_amount, :integer

      enum state: {
        init: 'init',
        pending: 'pending',
        transacted: 'transacted'
      }, _default: 'init'

      belongs_to :box_specification
      belongs_to :organ, class_name: 'Org::Organ', optional: true

      belongs_to :user, class_name: 'Auth::User'
      belongs_to :member, class_name: 'Org::Member', optional: true
      belongs_to :member_organ, class_name: 'Org::Organ', optional: true

      has_many :wallet_sells, as: :selled

      belongs_to :box_proxy_sell, ->(o) { where(organ_id: o.organ_id, price: o.price) }, foreign_key: :box_specification_id, primary_key: :box_specification_id, optional: true
      belongs_to :box_hold, ->(o) { where(organ_id: o.organ_id, box_specification_id: o.box_specification_id) }, primary_key: :user_id, foreign_key: :user_id

      before_validation :init_box_proxy_sell, if: -> { price.present? && (['price', 'amount'] & changes.keys).present? }
      before_validation :compute_rest_amount, if: -> { (['amount', 'pending_amount'] & changes.keys).present? }
    end

    def init_box_hold
      box_hold || build_box_hold
    end

    def init_box_proxy_sell
      box_proxy_sell || build_box_proxy_sell
    end

    def compute_rest_amount
      self.rest_amount = self.amount - self.pending_amount
    end

    def check_state
      self.state = 'pending'
    end

    def deal_rest_item
      r = box_proxy_sell.items.default_where('rest_number-gt': 0, 'single_price-gte': price).order(single_price: :asc, id: :asc).pluck(:id, :rest_number)
      usable = r.find_until(rest_amount)
      items = box_proxy_sell.items.find usable.keys

      r = items.each do |item|
        self.delivery_item(item)
      end

      self.class.transaction do |x|
        r.each(&:save!)
        self.save!
      end
    end

    def delivery_item(item)
      item.done_number = self.rest_amount
      self.done_amount += item.number
      ws = self.wallet_sells.build(wallet_id: user.lawful_wallet.id, item_id: item.id)
      ws.amount = self.price * self.pending_amount

      item
    end

    def delivery(item, amount)
      self.pending_amount = amount
      ws = self.wallet_sells.build(wallet_id: user.lawful_wallet.id, item_id: item.id)
      ws.amount = self.price * self.pending_amount

      item.done_number += pending_amount
      self
    end

  end
end
