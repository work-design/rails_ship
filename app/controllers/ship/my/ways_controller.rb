module Ship
  class My::WaysController < My::BaseController
    before_action :set_way, only: [:show, :edit, :update, :destroy]

    def index
      @ways = current_user.ways.order(id: :asc).page(params[:page])
    end

    def requirement
      @ways = current_user.ways.order(id: :asc).page(params[:page])
    end

    def new
      @way = current_user.ways.build
      @way.way_stations.build
    end

    def add
      @way = current_user.ways.build(way_params)
      @way.way_stations.select(&->(i){ i.position > params[:position].to_i }).each do |i|
        i.position += 1
      end
      @way.way_stations.build(position: params[:position].to_i + 1)
    end

    def select
      @way = current_user.ways.build
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
