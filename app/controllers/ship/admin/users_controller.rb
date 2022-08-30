module Ship
  class Admin::UsersController < Admin::BaseController

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:user_id)

      r = Trade::Item.packable.default_where(q_params).page(params[:page]).select(:user_id).group(:user_id).count
      r.delete(nil)
      @users = Auth::User.find(r.keys).zip r.values
    end

  end
end
