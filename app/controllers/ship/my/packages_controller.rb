module Ship
  class My::PackagesController < My::BaseController
    before_action :set_address
    before_action :set_package, only: [:show, :wait, :edit, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! params.permit(:produce_plan_id)
      @produce_plan = ProducePlan.find params[:produce_plan_id]
      @produce_plan.wait_lists.find_or_create_by(address_id: @address.id)

      @packages = @address.packages.default_where(q_params).page(params[:page])
    end

    def show
    end

    def wait
      wait_list = @address.wait_lists.find_by(wait_for_type: 'ProducePlan', wait_for_id: @package.produce_plan_id)
      wait_item = wait_list.wait_items.find_or_initialize_by(user_id: @package.user_id)
      @package.wait_item = wait_item

      if @package.save

      end
    end

    def edit
    end

    def update
      @package.assign_attributes(package_params)

      unless @package.save
        render :edit, locals: { model: @package }, status: :unprocessable_entity
      end
    end

    def destroy
      @package.destroy
    end

    private
    def set_address
      @address = current_user.principal_addresses.find params[:principal_address_id]
    end

    def set_package
      @package = @address.packages.find(params[:id])
    end

  end
end
