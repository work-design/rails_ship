module Ship
  module Model::Box
    extend ActiveSupport::Concern

    included do
      attribute :code, :string
      attribute :shipment_items_count, :integer, default: 0
      attribute :box_logs_count, :integer, default: 0

      enum status: {
        born: 'born',
        free: 'free',
        using: 'using'
      }, _default: 'born', _prefix: true
      enum state: {
        grid_in: 'grid_in',
        grid_out: 'grid_out',
        loaded: 'loaded',
        unloaded: 'unloaded'
      }, _prefix: true

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      belongs_to :box_specification, counter_cache: true

      has_many :packages, dependent: :nullify
      has_one :shipment_item, -> { order(id: :desc) }
      has_many :shipment_items
      has_many :shipments, through: :shipment_items
      has_many :box_logs
      has_many :using_box_logs, -> { where(boxed_out_at: nil) }, class_name: 'BoxLog'

      before_validation :init_code, if: -> { code.blank? }
    end

    def to_pdf
      pdf = BasePdf.new(width: 78.mm, height: 40.mm)
      pdf_content(pdf)
      pdf
    end

    def pdf_content(pdf)
      pdf.text code, size: 12
      pdf.text organ&.name
      pdf.text box_specification.measure
      pdf.bounding_box([pdf.bounds.right - 60, pdf.bounds.top], width: 60, height: 60) do
        pdf.image StringIO.new(qrcode_enter_png.to_blob), fit: [60, 60], position: :right, vposition: :top
      end
    end

    def enter_url
      Rails.application.routes.url_for(controller: 'ship/boxes', action: 'qrcode', id: self.id)
    end

    def qrcode_enter_png
      QrcodeHelper.code_png(enter_url, border_modules: 0, fill: 'pink')
    end

    def qrcode_enter_url
      QrcodeHelper.data_url(enter_url)
    end

    def init_code
      self.code = UidHelper.usec_uuid('BOX')
    end

  end
end
