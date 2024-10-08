module Ship
  module Model::BoxSell
    extend ActiveSupport::Concern

    included do
      attribute :price, :decimal
      attribute :amount, :integer
      attribute :done_amount, :integer, default: 0
      attribute :rest_amount, :integer

      enum :state, {
        init: 'init',
        pending: 'pending',
        transacted: 'transacted'
      }, default: 'init'

      belongs_to :box_specification
      belongs_to :organ, class_name: 'Org::Organ', optional: true

      belongs_to :user, class_name: 'Auth::User'
      belongs_to :member, class_name: 'Org::Member', optional: true
      belongs_to :member_organ, class_name: 'Org::Organ', optional: true

      has_many :wallet_sells, as: :selled, class_name: 'Trade::WalletSell'

      belongs_to :box_proxy_sell, ->(o) { where(organ_id: o.organ_id, price: o.price) }, foreign_key: :box_specification_id, primary_key: :box_specification_id, optional: true
      belongs_to :box_hold, ->(o) { where(organ_id: o.organ_id, user_id: o.user_id, member_id: o.member_id) }, foreign_key: :box_specification_id, primary_key: :box_specification_id
      belongs_to :box_host, ->(o) { where(organ_id: o.organ_id) }, foreign_key: :box_specification_id, primary_key: :box_specification_id

      before_validation :init_box_proxy_sell, if: -> { price.present? && (['price', 'amount'] & changes.keys).present? }
      before_validation :compute_rest_amount, if: -> { (['amount', 'done_amount'] & changes.keys).present? }
      after_save :reset_proxy_count, if: -> { saved_change_to_rest_amount? }
      after_destroy :reset_proxy_count
      after_save_commit :deal_rest_item, if: -> { (saved_changes.keys & ['amount']).present? }
    end

    def init_box_hold
      box_hold || build_box_hold
    end

    def init_box_proxy_sell
      box_proxy_sell || build_box_proxy_sell
    end

    def reset_proxy_count
      box_proxy_sell&.reset_sellable_count!
    end

    def compute_rest_amount
      self.rest_amount = self.amount - self.done_amount
    end

    def check_state
      self.state = 'pending'
    end

    def lawful_wallet
      user.lawful_wallets.find_by(organ_id: organ_id) || user.lawful_wallets.create(organ_id: organ_id)
    end

    # 触发自动交易
    def deal_rest_item
      # 买入价更高的优先，同等价格下先发布的优先
      r = box_host.items.deliverable.default_where('rest_number-gt': 0, 'single_price-gte': price).order(single_price: :desc, id: :asc).pluck(:id, :rest_number)
      usable = r.find_until(rest_amount)
      return if usable.blank?
      items = box_host.items.find usable.map(&:first)

      r = items[0..-2].each do |item|
        self.delivery_item(item, item.rest_number)
      end
      last_item = items[-1]
      if self.done_amount + last_item.rest_number > self.rest_amount
        self.delivery_item(last_item, self.rest_amount - self.done_amount)
      else
        self.delivery_item(last_item, last_item.rest_number)
      end
      r << last_item

      self.class.transaction do
        r.each(&:save!)
        self.save!
      end
    end

    def delivery_item(item, num)
      ws = self.wallet_sells.build(wallet_id: lawful_wallet.id, item_id: item.id)
      ws.amount = self.price * num
      item.done_number += num
      self.done_amount += num

      item
    end

    def delivery(item, num)
      ws = self.wallet_sells.build(wallet_id: lawful_wallet.id, item_id: item.id)
      ws.amount = self.price * num
      self.done_amount += num
      item.done_number += num

      self
    end

  end
end
