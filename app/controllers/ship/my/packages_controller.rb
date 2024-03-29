module Ship
  class My::PackagesController < My::BaseController
    before_action :set_package, only: [
      :show, :edit, :update, :destroy, :actions,
      :qrcode, :wait, :receive
    ]

    def index
      q_params = {}
      q_params.merge! params.permit(:produce_plan_id)

      @packages = current_user.packages.default_where(q_params).page(params[:page])
    end

    def qrcode
    end

    def wait
      wait_list = @address.wait_lists.find_by(wait_for_type: 'ProducePlan', wait_for_id: @package.produce_plan_id)
      wait_item = wait_list.wait_items.find_or_initialize_by(user_id: @package.user_id)
      @package.wait_item = wait_item

      if @package.save

      end
    end

    # 确认收货
    def receive
      @package.state = 'received'
      @package.save
    end

    private
    def set_address
      @address = current_user.addresses.find params[:address_id]
    end

    def set_produce_plan
      @produce_plan = ProducePlan.find params[:produce_plan_id]
      @produce_plan.wait_lists.find_or_create_by(address_id: @address.id)
    end

    def set_package
      @package = current_user.packages.find(params[:id])
    end

  end
end
