module Ship
  class Me::BoxesController < Me::BaseController
    before_action :set_box, only: [:qrcode, :in, :out, :loaded, :unloaded]
    before_action :set_boxed_from_scan, only: [:in, :out]
    before_action :set_shipment_from_scan, only: [:loaded, :unloaded]

    def index
      q_params = {}
      q_params.merge! default_params

      @boxes = Box.default_where(q_params).page(params[:page])
    end

    # 装入包裹
    def in
      if @boxed
        bl = @box.box_logs.find_or_initialize_by(boxed_type: @boxed.base_class_name, boxed_id: @boxed.id)
        bl.boxed_in_at ||= Time.current
        bl.save
      end
    end

    # 取出包裹
    def out
      if @boxed
        bl = @box.box_logs.find_by(boxed_type: @boxed.base_class_name, boxed_id: @boxed.id)
        bl.boxed_out_at = Time.current
        bl.save
      end
    end

    # 装车
    def loaded
      if @shipment
        @box.assign_attributes params.permit(:box_id)
        @box.state = 'loaded'
        @box.save
      end
    end

    # 卸车
    def unloaded
      if @shipment
        @box.assign_attributes params.permit(:box_id)
        @box.state = 'unloaded'
        @box.save
      end
    end

    def qrcode
    end

    private
    def set_box
      @box = Box.default_where(default_params).find params[:id]
    end

    def set_boxed_from_scan
      r = params[:result].scan(RegexpUtil.more_between('packages/', '/qrcode'))
      if r.present?
        @boxed = Package.find r[0]
        return
      end

      r = params[:result].scan(RegexpUtil.more_between('production_items/', '/qrcode'))
      @boxed = Factory::ProductionItem.find r[0] if r.present?
    end

    def set_shipment_from_scan
      r = params[:result].scan(RegexpUtil.more_between('shipments/', '/qrcode'))
      if r.present?
        @shipment = Shipment.find r[0]
      end
    end

  end
end
