module Ship
  class Panel::BoxHostsController < Panel::BaseController
    before_action :set_box_specification

    def index
      q_params = {}

      @box_hosts = @box_specification.box_hosts.default_where(q_params).order(id: :asc).page(params[:page])
    end

    private
    def set_box_specification
      @box_specification = BoxSpecification.find params[:box_specification_id]
    end

  end
end
