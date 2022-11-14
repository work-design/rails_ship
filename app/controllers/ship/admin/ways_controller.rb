module Ship
  class Admin::WaysController < Admin::BaseController

    def index
      q_params = {}
      q_params.merge! default_params

      @ways = Way.default_where(q_params).page(params[:page])
    end

  end
end
