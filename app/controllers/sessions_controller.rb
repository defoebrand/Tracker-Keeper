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
    user = User.find_by_name(params[:name])
    if user && (user[:name] == params[:name])
      session[:user_id] = user.id
      redirect_to user_path(session[:user_id]), notice: 'Logged in!'
    else
      flash.now[:alert] = 'Name or email is invalid'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end
end
