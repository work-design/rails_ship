module Ship
  class Admin::PackagesController < Admin::BaseController
    before_action :set_package, only: [:show, :edit, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! params.permit(:address_id)

      @packages = Package.includes(:packageds, :address).default_where(q_params).page(params[:page])
    end

    def show
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
    def set_package
      @package = Package.find(params[:id])
    end

    def package_params
      params.fetch(:package, {}).permit(
        :state,
        :expected_on,
      )
    end

  end
end
