class ApplicationController < ActionController::Base
  private

  def check_user_log_in
    @user = User.find(session[:user_id])
    redirect_to root_path unless @user
  end
end
