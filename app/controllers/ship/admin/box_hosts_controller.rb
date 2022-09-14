module Ship
  class Admin::BoxHostsController < Admin::BaseController

    def index
      @box_hosts = BoxHost.includes(:box_specification).page(params[:page])

      @box_specifications = BoxSpecification.where.not(id: @box_hosts.pluck(:box_specification_id).uniq)
    end

    private
    def box_host_params
      p = params.fetch(:box_host, {}).permit(
        :box_specification_id
      )
      p.merge! default_form_params
    end

  end
end
