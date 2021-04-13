module Ship
  class Panel::SimilarsController < Panel::BaseController
    before_action :set_line
    before_action :set_similar, only: [:show, :edit, :update, :destroy]

    def index
      @similars = @line.similars.page(params[:page])
    end

    def new
      @similars = Line.page(params[:page])
    end

    def create
      @line_similar = @line.line_similars.build(similar_params)

      unless @similar.save
        render :new, locals: { model: @similar }, status: :unprocessable_entity
      end
    end

    def show
    end

    def edit
    end

    def update
      @similar.assign_attributes(similar_params)

      unless @similar.save
        render :edit, locals: { model: @similar }, status: :unprocessable_entity
      end
    end

    def destroy
      @similar.destroy
    end

    private
    def set_line
      @line = Line.find params[:line_id]
    end

    def set_similar
      @similar = Line.find(params[:id])
    end

    def similar_params
      params.fetch(:line_similar, {}).permit(
        :name,
        :position
      )
    end

  end
end
