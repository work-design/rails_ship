module Ship
  class Admin::StationsController < Admin::BaseController
    before_action :set_new_station, only: [:new, :create]
    before_action :set_station, only: [
      :show, :edit, :update, :destroy, :actions,
      :lines, :shipments
    ]

    def index
      q_params = {}
      q_params.merge! default_params

      @stations = Station.includes(:area).default_where(q_params).order(id: :asc).page(params[:page])
    end

    def new
      if defined?(current_organ) && current_organ
        @station.area = current_organ.area || Area.new
      else
        @station.area = Area.new
      end
    end

    def lines
      @line_stations = @station.line_stations.includes(:line)
    end

    def shipments
      q_params = {
        #state: ['left', 'arrived'],
        current_line_station_id: @station.line_station_ids
      }
      q_params.merge! params.permit(:state)

      @shipments = @station.shipments.includes(:car, :driver, :line).default_where(q_params).order(load_on: :desc)
    end

    private
    def set_station
      @station = Station.find params[:id]
    end

    def set_new_station
      @station = Station.new(station_params)
    end

    def station_params
      p = params.fetch(:station, {}).permit(
        :name,
        :detail,
        :lat,
        :lng,
        :poiname,
        :poiaddress,
        :cityname,
        :area_ancestors
      )
      p.merge! default_form_params
    end

  end
end
