module Ship
  class Driver::BaseController < MyController


    def current_driver
      current_user.driver
    end

  end
end
