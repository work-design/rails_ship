module Ship
  class Panel::LinesController < Panel::BaseController
    before_action :set_line, only: [:show, :edit, :update, :destroy]

    def index
      @lines = Line.page(params[:page])
    end

    def new
      @line = Line.new
    end

    def create
      @line = Line.new(line_params)

      unless @line.save
        render :new, locals: { model: @line }, status: :unprocessable_entity
      end
    end

    def show
    end

    def edit
    end

    def update
      @line.assign_attributes(line_params)

      unless @line.save
        render :edit, locals: { model: @line }, status: :unprocessable_entity
      end
    end

    def destroy
      @line.destroy
    end

    private
    def set_line
      @line = Line.find(params[:id])
    end

    def line_params
      params.fetch(:line, {}).permit(
        :name,
        :start_name,
        :finish_name
      )
    end

  end
end
