class SessionsController < ApplicationController
  before_action :redirect_login, only: %i[index edit new show]

  def index; end

  def edit; end

  def new; end

  def show; end

  def create
    find_or_create_user

    if @user
      session[:user_id] = @user.id
      redirect_to user_path(session[:user_id]), notice: 'Logged in!'
    else
      flash.now[:alert] = 'Name or email is invalid'
      render 'users/splash'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end

  private

  def omniauth_hash
    request.env['omniauth.auth']
  end

  def find_or_create_user
    @user = omniauth_hash.nil? ? User.find_by_name(params[:name]) : User.from_omniauth(omniauth_hash)
    @user
  end

  def redirect_login
    session[:user_id] ? (redirect_to user_path(session[:user_id])) : (redirect_to root_path)
  end
end
