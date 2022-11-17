module Ship
  class In::OrdersController < Trade::In::OrdersController
    before_action :set_order, only: [:show, :edit, :update, :payment_types, :edit_payment_type]

    def index
      q_params = {}
      q_params.merge! params.permit(:id, :payment_type, :payment_status, :state)

      @orders = current_organ.member_orders.includes(:items).default_where(q_params).order(id: :desc).page(params[:page])
    end

    private
    def set_order
      @order = current_organ.member_orders.find params[:id]
    end

    def order_params
      p = params.fetch(:order, {}).permit(
        :pay_later,
        :current_cart_id,
        :note
      )
      p.merge! current_cart_id: params[:current_cart_id]
    end

  end
end

