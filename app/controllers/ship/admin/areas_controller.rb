class Trade::Admin::AreasController < Trade::Admin::BaseController
  before_action :set_area, only: [:show, :edit, :update, :destroy]

  def index
    @areas = Area.unscoped.page(params[:page])
  end

  def show
  end

  def new
    @area = Area.new
  end

  def edit
  end

  def create
    @area = Area.new area_params

    if @area.save
      redirect_to admin_areas_url, notice: '地区添加成功'
    else
      render action: 'new'
    end
  end

  def update
    if @area.update area_params
      redirect_to admin_areas_url, notice: 'Area was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @area.destroy
    redirect_to admin_areas_url
  end

  private
  def set_area
    @area = Area.unscoped.find params[:id]
  end

  def area_params
    params[:area].permit(:nation, :province, :city, :popular, :published)
  end

end
