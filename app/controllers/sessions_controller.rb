class SessionsController < ApplicationController
  def index
    if session[:user_id]
      redirect_to user_path(session[:user_id])
    else
      redirect_to root_path
    end
  end

  def edit
    if session[:user_id]
      redirect_to user_path(session[:user_id])
    else
      redirect_to root_path
    end
  end

  def new
    redirect_to user_path(session[:user_id]) if session[:user_id]
  end

  def show
    if session[:user_id]
      redirect_to user_path(session[:user_id])
    else
      redirect_to root_path
    end
  end

  def create
    # auth_hash.to_json
    # raise env['omniauth.auth'].to_yaml

    user = omniauth_hash.nil? ? User.find_by(user_params) : User.from_omniauth(omniauth_hash)
    # user = User.from_omniauth(env['omniauth.auth'])
    # user = User.find_or_create_by(params)
    # user = auth_hash.nil? ? User.find_by_name(params[:name]) : User.new(auth_hash)

    # self.current_user = @user
    # redirect_to '/'
    # user = User.find_by_name(params[:name])
    # if user && (user[:name] == params[:name])
    if user
      session[:user_id] = user.id
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
end
