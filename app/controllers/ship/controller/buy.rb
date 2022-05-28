module Ship
  module Controller::Buy
    extend ActiveSupport::Concern

    included do
      layout 'admin'
    end

    class_methods do
      def local_prefixes
        [controller_path, 'ship/buy/base', 'buy', 'admin']
      end
    end

  end
end
