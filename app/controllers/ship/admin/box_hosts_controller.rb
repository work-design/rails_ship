module Ship
  class Admin::BoxHostsController < Admin::BaseController
    before_action :set_box_host, only: [
      :show, :edit, :update, :destroy, :actions,
      :wallet, :update_wallet
    ]

    def index
      q_params = {}
      q_params.merge! default_params

      @box_hosts = BoxHost.includes(:box_specification).default_where(q_params).order(id: :asc).page(params[:page])

      @box_specifications = BoxSpecification.where.not(id: @box_hosts.pluck(:box_specification_id).uniq)
    end

    def wallet
      @wallet_templates = Trade::WalletTemplate.default_where(default_params)
    end

    def update_wallet
      @box_host.wallet_price = wallet_price_params
      @box_host.save
    end

    private
    def set_box_host
      @box_host = BoxHost.find params[:id]
    end

    def box_host_params
      p = params.fetch(:box_host, {}).permit(
        :box_specification_id,
        :price,
        :invest_ratio,
        :rent_unit,
        :logo
      )
      p.merge! default_form_params
    end

    def wallet_price_params
      r = {}

      params.fetch(:box_host, {}).fetch(:wallet_price, {}).each do |_, v|
        r.merge! v[:code] => v[:price]
      end

      r
    end

  end
end
