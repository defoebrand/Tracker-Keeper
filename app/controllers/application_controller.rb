class ApplicationController < ActionController::Base
  private

  def check_user_log_in
    redirect_to root_path unless session[:user_id]
  end

  def set_user
    @user = User.with_attached_avatar.find(session[:user_id])
  end

  def share_groups
    @groups = Group.all
  end
end
