module Ship
  class Panel::SimilarsController < Panel::BaseController
    before_action
    before_action :set_similar, only: [:show, :edit, :update, :destroy]

    def index
      @similars = @Line.similars.page(params[:page])
    end

    def new
      @similar = Similar.new
    end

    def create
      @similar = Similar.new(similar_params)

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
      params.fetch(:similar, {}).permit(
        :name,
        :start_name,
        :finish_name
      )
    end

  end
end
