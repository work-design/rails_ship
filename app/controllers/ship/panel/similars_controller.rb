module Ship
  class Panel::SimilarsController < Panel::BaseController
    before_action :set_line
    before_action :set_similar, only: [:show, :edit, :update, :destroy]

    def index
      @similars = @line.similars.page(params[:page])
    end

    def new
      @similars = @line.similars.page(params[:page])
      @lines = Line.where.not(id: @line.similar_ids).page(params[:page])
    end

    def create
      @line_similar = @line.line_similars.build
      @line_similar.similar_id = params[:similar_id]

      unless @line_similar.save
        render :new, locals: { model: @line_similar }, status: :unprocessable_entity
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
      @line_similar = @line.line_similars.find_by(similar_id: params[:id])
      @line_similar.destroy
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
        :similar_id,
        :position
      )
    end

  end
end
