module Ship
  class Dri::BaseController < MyController

    def current_driver
      @current_driver = current_user.driver
    end

  end
end
