class ApplicationController < ActionController::Base
  private

  def check_user_log_in
    @user = User.with_attached_avatar.find(session[:user_id])
    redirect_to root_path unless @user
  end
end
