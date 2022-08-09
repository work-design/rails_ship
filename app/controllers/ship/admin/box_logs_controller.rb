module Ship
  class Admin::BoxLogsController < Admin::BaseController
    before_action :set_box

    def index
      @box_logs = @box.box_logs.includes(:package).page(params[:page])
    end

    private
    def set_box
      @box = Box.find params[:box_id]
    end
  end
end
