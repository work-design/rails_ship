module Ship
  class Panel::LinesController < Panel::BaseController
    before_action :set_line, only: [:show, :edit, :update, :destroy]
    before_action :set_new_line, only: [:new, :create]

    def index
      @lines = Line.page(params[:page])
    end

    private
    def set_line
      @line = Line.find(params[:id])
    end

    def set_new_line
      @line = Line.new(line_params)
    end

    def line_params
      params.fetch(:line, {}).permit(
        :name
      )
    end

  end
end
