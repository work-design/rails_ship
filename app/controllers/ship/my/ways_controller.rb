module Ship
  class My::WaysController < My::BaseController
    before_action :set_way, only: [:show, :edit, :update, :destroy]
    before_action :set_new_way, only: [:new, :add, :select, :create]

    def index
      @ways = current_user.ways.order(id: :asc).page(params[:page])
    end

    def requirement
      @ways = current_user.ways.order(id: :asc).page(params[:page])
    end

    def new
      @location = @way.locations.build
    end

    def add
      @way.locations.select(&->(i){ i.position > params[:index].to_i }).each do |i|
        i.position += 1
      end
      @location = @way.locations.build(position: params[:index].to_i + 1)
    end

    def select
    end

    def show
      @similars = @way.similars
    end

    private
    def set_way
      @way = current_user.ways.find(params[:id])
    end

    def set_new_way
      @way = current_user.ways.build(way_params)
    end

    def way_params
      params.fetch(:way, {}).permit(
        :start_name,
        :finish_name,
        locations_attributes: {}
      )
    end

  end
end
