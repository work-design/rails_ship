module Ship
  class Admin::PackagesController < Admin::BaseController
    before_action :set_package, only: [:show, :edit, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:address_id)

      @packages = Package.includes(:packageds, :address).default_where(q_params).order(id: :desc).page(params[:page])
    end

    private
    def set_package
      @package = Package.find(params[:id])
    end

    def package_params
      p = params.fetch(:package, {}).permit(
        :state,
        :expected_on
      )
      p.merge! default_form_params
    end

  end
end
