module Ship
  class My::LinesController < My::BaseController
    before_action :set_line, only: [:show, :edit, :update, :destroy]

    def index
      @lines = current_user.lines.order(id: :asc).page(params[:page])
    end

    def new
      @line = current_user.lines.build
      @line.locations.build(position: 1)
    end

    def add
      @line = current_user.lines.build(line_params)
      @line.locations.select(&->(i){ i.position > params[:position].to_i }).each do |i|
        i.position += 1
      end
      @line.locations.build(position: params[:position].to_i + 1)
    end

    def select
      @line = current_user.lines.build
    end

    def create
      @line = current_user.lines.build(line_params)

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
      @line = current_user.lines.find(params[:id])
    end

    def line_params
      params.fetch(:line, {}).permit(
        :start_name,
        :finish_name,
        locations_attributes: {}
      )
    end

  end
end
